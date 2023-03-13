import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/dialogs/product_download_dialog.dart';
import 'package:genesis_robotec/app/core/models/app_stream.dart';
import 'package:genesis_robotec/app/core/services/notification_service.dart';
import 'package:genesis_robotec/app/modules/product/product_model.dart';
import 'package:genesis_robotec/app/modules/product/product_provider.dart';
import 'package:genesis_robotec/app/modules/product/product_repository.dart';
import 'package:path_provider/path_provider.dart';

class ProductController {
  static final ProductController _instance = ProductController._();

  ProductController._();

  factory ProductController() => _instance;

  //* Keys *//

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  BuildContext get context => key.currentState!.context;

  //* Providers *//

  //* Controller *//

  //* IMPL *//

  final AppStream<List<Kit>> kits = AppStream<List<Kit>>();
  final AppStream<Kit> kit = AppStream<Kit>();
  final AppStream<Product> product = AppStream<Product>();
  final AppStream<ProductUtils> utils = AppStream<ProductUtils>.seeded(ProductUtils());
  final AppStream<ProductStep> stepStream = AppStream<ProductStep>();
  final AppStream<ProductDownload> downloadStream =
      AppStream<ProductDownload>.seeded(ProductDownload());

  Future<void> getKits() async {
    final response = await ProductProvider.getKits();
    await saveKitsLocally(response.hasData ? response.data : []);
    final kitsLocally = ProductRepository.getKits();
    kits.add(kitsLocally);
    // if (product.controller.hasValue) {
    //   final kitInList = values.where((e) => e.name == kit.value.name).toList();
    //   if (kitInList.isNotEmpty) {
    //     final productInList =
    //         kitInList.first.itens.where((e) => e.name == product.controller.value.name).toList();
    //     if (productInList.isNotEmpty) {
    //       product.add(productInList.first);
    //     }
    //   }
    // }
  }

  Future<void> saveKitsLocally(List<Kit> kitsApi) async {
    final kitsLocally = ProductRepository.getKits();
    for (var kitApi in kitsApi) {
      final kit = kitsLocally.where((e) => e.name == kitApi.name).toList();
      if (kit.isNotEmpty) {
        if (kitApi.version > kit.first.version) {
          if (kit.first.downloaded) {
            await downloadKit(kitApi);
          }
          ProductRepository.addKit(kitApi);
        }
      } else {
        ProductRepository.addKit(kitApi);
      }
    }
  }

  Future<void> updateKits() async {
    await getKits();
  }

  Future<void> downloadKit(Kit kit) async {
    try {
      for (var product in kit.products) {
        await downloadProduct(product);
      }
      await kit.save();
    } catch (e) {
      throw Error();
    }
  }

  Future<void> downloadProduct(Product product) async {
    try {
      await deleteDirectory(product.kitName, product.name);
      downloadStream.value.reset();
      downloadStream.update();
      downloadStream.value.length = product.steps.length + 4;
      setDownloadNextStep('Baixando imagem');
      product.image =
          await downloadArchive(product.kitName, product.name, 'image.png', product.image);
      setDownloadNextStep('Baixando pdf');
      product.pdf = await downloadArchive(product.kitName, product.name, 'pdf.pdf', product.pdf);
      setDownloadNextStep('Baixando modelo 3D');
      product.model =
          await downloadArchive(product.kitName, product.name, 'model.glb', product.model);
      for (var step in product.steps) {
        setDownloadNextStep(
            'Baixando passo a passo (${product.steps.indexOf(step) + 1}/${product.steps.length})');
        step.model = await downloadArchive(
            product.kitName, product.name, 'step/${product.steps.indexOf(step)}.glb', step.model);
      }
      setDownloadNextStep('Salvando dados');
      product.downloaded = true;
      for (var step in product.steps) {
        step.downloaded = true;
      }
      await saveKit(product);
      downloadStream.add(ProductDownload());
    } catch (e) {
      throw Error();
    }
  }

  Future<void> saveKit(Product product) async {
    for (var kit in ProductRepository.getKits()) {
      if (kit.name == product.kitName) {
        kit.downloaded = true;
        kit.save();
      }
    }
  }

  Future<String> downloadArchive(String kit, String product, String name, String archive) async {
    try {
      final path = '${(await getTemporaryDirectory()).path}/$kit/$product/$name';
      await Dio().download(archive, path);
      return path;
    } catch (e) {
      throw Error();
    }
  }

  Future<void> deleteDirectory(String kit, String product) async {
    final Directory dir = Directory('${(await getTemporaryDirectory()).path}/$kit/$product');
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }

  Future<void> onProductDownload(BuildContext context, Product product) async {
    if (!product.downloaded) {
      showDialog(context: context, builder: (_) => const ProductDownloadDialog(), barrierDismissible: false);
      try {
        await downloadProduct(product);
        Navigator.pop(context);
        NotificationService.positive('Produto baixado com sucesso!');
        final kitsLocally = ProductRepository.getKits();
        kits.add(kitsLocally);
      } catch (e) {
        Navigator.pop(context);
        NotificationService.negative('Não foi possível realizar o download do produto!');
      }
    }
  }

  void setDownloadNextStep(String title) {
    downloadStream.value.title = title;
    downloadStream.value.current = downloadStream.value.current + 1;
    downloadStream.add(downloadStream.value);
  }
}

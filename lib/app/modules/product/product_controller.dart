import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/models/app_stream.dart';
import 'package:genesis_robotec/app/core/services/notification_service.dart';
import 'package:genesis_robotec/app/core/utils/dialog_utils.dart';
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
      product.image = await downloadArchive('image.png', product.image);
      product.pdf = await downloadArchive('pdf.pdf', product.pdf);
      product.model = await downloadArchive('model.glb', product.model);
      for (var step in product.steps) {
        step.model = await downloadArchive('step/${product.steps.indexOf(step)}.glb', step.model);
      }
      product.downloaded = true;
      for (var step in product.steps) {
        step.downloaded = true;
      }
      await saveKit(product);
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

  Future<String> downloadArchive(String name, String archive) async {
    try {
      final path = '${(await getTemporaryDirectory()).path}/$name';
      await Dio().download(archive, path);
      return path;
    } catch (e) {
      throw Error();
    }
  }

  Future<void> onProductDownload(BuildContext context, Product product) async {
    if (!product.downloaded) {
      DialogUtils.showLoadingDialog(context);
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
}

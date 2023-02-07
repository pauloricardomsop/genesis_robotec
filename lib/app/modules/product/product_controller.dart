import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/models/app_stream.dart';
import 'package:genesis_robotec/app/modules/product/product_model.dart';
import 'package:genesis_robotec/app/modules/product/product_repository.dart';

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

  final AppStream<List<ProductKit>> kits = AppStream<List<ProductKit>>();
  final AppStream<ProductKit> kit = AppStream<ProductKit>();
  final AppStream<Product> product = AppStream<Product>();

  Future<void> getKits() async {
    kits.add(ProductRepository.getKits());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis_robotec/app/app_widget.dart';
import 'package:genesis_robotec/app/modules/product/product_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ProductRepository.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const AppWidget());
}

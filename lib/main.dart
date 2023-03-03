import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:genesis_robotec/app/app_widget.dart';
import 'package:genesis_robotec/app/core/services/connectivity_service.dart';
import 'package:genesis_robotec/app/core/services/package_info_service.dart';
import 'package:genesis_robotec/firebase_options.dart';

import 'app/core/services/hive/hive_service.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ConnectivyService.init();
  await HiveService.init();
  await PackageInfoService.fetchInfo();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(const AppWidget());
}

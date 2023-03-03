import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/enum/app_page.dart';
import 'package:genesis_robotec/app/core/models/app_stream.dart';

class HomeController {
  static final HomeController _instance = HomeController._();

  HomeController._();

  factory HomeController() => _instance;

  final GlobalKey<ScaffoldState> scaffoldHomeKey = GlobalKey<ScaffoldState>();
  final PageController pageHomeController = PageController();

  AppStream<AppPage> pageStream = AppStream<AppPage>.seeded(AppPage.kits);
}

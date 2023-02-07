import 'package:flutter/material.dart';

class AppController {
  static final AppController _instance = AppController._();

  AppController._();

  factory AppController() => _instance;

  //* Keys *//

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  BuildContext get context => key.currentState!.context;

  //* Providers *//

  //* Controller *//

  //* IMPL *//

}

import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/app_controller.dart';
import 'package:genesis_robotec/app/core/theme/app_theme.dart';
import 'package:overlay_support/overlay_support.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppController _appController = AppController();

  @override
  void initState() {
    AppController().onAppInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        navigatorKey: _appController.key,
        debugShowCheckedModeBanner: false,
        title: 'PGR',
        theme: AppTheme.theme,
        home: Container(),
      ),
    );
  }
}

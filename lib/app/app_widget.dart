import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/app_controller.dart';
import 'package:genesis_robotec/app/core/theme/app_theme.dart';
import 'package:genesis_robotec/app/modules/product/ui/kits_page.dart';
import 'package:overlay_support/overlay_support.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final AppController _appController = AppController();

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
          navigatorKey: _appController.key,
          debugShowCheckedModeBanner: false,
          title: 'Genesis Robotec',
          theme: AppTheme.theme,
          home: const KitsPage()),
    );
  }
}

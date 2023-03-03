import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/modules/about/ui/about_page.dart';
import 'package:genesis_robotec/app/modules/help/ui/help_page.dart';
import 'package:genesis_robotec/app/modules/product/ui/kits_page.dart';

enum AppPage {
  kits('Kits', Icons.dashboard_outlined, KitsPage()),
  help('Ajuda', Icons.help_outline, HelpPage()),
  about('Sobre', Icons.info_outline, AboutPage());

  final String label;
  final IconData icon;
  final Widget widget;

  const AppPage(this.label, this.icon, this.widget);
}

import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/modules/about/ui/about_page.dart';
import 'package:genesis_robotec/app/modules/product/ui/kits_page.dart';
import 'package:genesis_robotec/app/modules/rights/ui/rights_page.dart';

enum AppPage {
  kits('Kits', Icons.dashboard_outlined, KitsPage()),
  know('Conheça a Genesis Robotec', Icons.info_outline, AboutPage()),
  rights('Direitos Autorais', Icons.description_outlined, RightsPage());

  final String label;
  final IconData icon;
  final Widget widget;

  const AppPage(this.label, this.icon, this.widget);
}

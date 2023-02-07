import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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

  final mapController = MapController();

  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 2)).then((value) {
    //   proj4dart.Projection sirgas2000 = proj4dart.Projection.add('EPSG:31982',
    //       '+proj=utm +zone=22 +south +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs');

    //   proj4dart.Projection wgs84 = proj4dart.Projection.WGS84;

    //   final sirgas2000Coords = proj4dart.Point(x: -26.43302, y: -51.56133);

    //   final wgs84Coords = sirgas2000.transform(wgs84, sirgas2000Coords);

    //   final latlng = mapController.pointToLatLng(CustomPoint(wgs84Coords.x, wgs84Coords.y));

    //   log(latlng.toString());
    // });

    super.initState();
  }

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

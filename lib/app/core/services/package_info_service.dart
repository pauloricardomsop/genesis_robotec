import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService {
  static String version = '0.0.0';
  static Future<void> fetchInfo() async {
    final info = await PackageInfo.fromPlatform();
    version = info.version;
  }
}

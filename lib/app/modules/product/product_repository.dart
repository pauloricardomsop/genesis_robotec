import 'dart:io';

import 'package:genesis_robotec/app/core/services/hive/hive_box.dart';
import 'package:genesis_robotec/app/modules/product/product_model.dart';
import 'package:path_provider/path_provider.dart';

class ProductRepository {
  static List<Kit> getKits() => HiveBox.kit.values.toList();

  static Future<void> addKit(Kit kit) async {
    final kits = getKits().where((e) => e.name == kit.name).toList();
    if (kits.isNotEmpty) {
      HiveBox.kit.put(kits.first.key, kit);
    } else {
      HiveBox.kit.add(kit);
    }
  }

  static Future<String> saveArchive(List<int> bytes) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      File file = File('${tempDir.path}/$bytes');
      file.writeAsBytesSync(bytes);
      return file.path;
    } catch (e) {
      throw Error();
    }
  }
}

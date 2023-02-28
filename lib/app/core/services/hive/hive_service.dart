import 'package:genesis_robotec/app/core/services/hive/hive_box.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../modules/product/product_model.dart';

class HiveService {
  static late Box<Kit> kit;

  static Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    registerAdapters();
    await HiveBox.open();
  }

  static void registerAdapters() {
    Hive.registerAdapter<Kit>(KitAdapter());
    Hive.registerAdapter<Product>(ProductAdapter());
    Hive.registerAdapter<ProductStep>(StepAdapter());
  }
}

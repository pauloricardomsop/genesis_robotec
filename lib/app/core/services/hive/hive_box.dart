import 'package:genesis_robotec/app/modules/product/product_model.dart';
import 'package:hive/hive.dart';

class HiveBox {
  static late Box<Kit> kit;

  static Future<void> open() async {
    kit = await Hive.openBox<Kit>('process');
  }

  static Future<void> clear() async {
    await kit.clear();
  }
}

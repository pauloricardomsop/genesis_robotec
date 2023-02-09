import 'dart:convert';

import 'package:genesis_robotec/app/modules/product/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository {
  static late SharedPreferences _sharedPreferences;

  static const _kitKey = 'kits';

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_hasKitsInDB) await _insertKits();
  }

  static Future<void> _insertKits() async {
    await _sharedPreferences.setString(_kitKey, jsonEncode(_data));
  }

  static List<ProductKit> getKits() => jsonDecode(_sharedPreferences.getString(_kitKey)!)
      .map<ProductKit>((e) => ProductKit.fromMap(e))
      .toList();

  static bool get _hasKitsInDB => _sharedPreferences.getString(_kitKey) == null;

  static Future<void> updateKits(List<ProductKit> products) async {
    await _sharedPreferences.setString(_kitKey, jsonEncode(products.map((e) => e.toMap()).toList()));
  }

  static final List<Map<String, dynamic>> _data = [
    {
      "name": "Encaixes e Equilíbrio I",
      "favorite": false,
      "itens": [
        {
          "name": "Tangram 3D",
          "favorite": false,
          "image": "https://www.napratica.org.br/wp-content/uploads/2018/06/robo.jpg",
          "video": "https://www.youtube.com/watch?v=-dfFyWqf9V4&ab_channel=GenesisRobotec",
          "pdf": "https://www.caceres.mt.gov.br/fotos_institucional_downloads/2.pdf",
          "model3d": "https://www.caceres.mt.gov.br/fotos_institucional_downloads/2.pdf",
        },
        {
          "name": "Tangram 3D",
          "favorite": false,
          "image": "https://www.napratica.org.br/wp-content/uploads/2018/06/robo.jpg",
          "video": "https://www.youtube.com/watch?v=-dfFyWqf9V4&ab_channel=GenesisRobotec",
          "pdf": "https://www.caceres.mt.gov.br/fotos_institucional_downloads/2.pdf",
          "model3d": "https://www.caceres.mt.gov.br/fotos_institucional_downloads/2.pdf",
        },
        {
          "name": "Tangram 3D",
          "favorite": false,
          "image": "https://www.napratica.org.br/wp-content/uploads/2018/06/robo.jpg",
          "video": "https://www.youtube.com/watch?v=-dfFyWqf9V4&ab_channel=GenesisRobotec",
          "pdf": "https://www.caceres.mt.gov.br/fotos_institucional_downloads/2.pdf",
          "model3d": "https://www.caceres.mt.gov.br/fotos_institucional_downloads/2.pdf",
        },
        {
          "name": "Tangram 3D",
          "favorite": false,
          "image": "https://www.napratica.org.br/wp-content/uploads/2018/06/robo.jpg",
          "video": "https://www.youtube.com/watch?v=-dfFyWqf9V4&ab_channel=GenesisRobotec",
          "pdf": "https://www.caceres.mt.gov.br/fotos_institucional_downloads/2.pdf",
          "model3d": "https://www.caceres.mt.gov.br/fotos_institucional_downloads/2.pdf",
        },
        {
          "name": "Tangram 3D",
          "favorite": false,
          "image": "https://www.napratica.org.br/wp-content/uploads/2018/06/robo.jpg",
          "video": "https://www.youtube.com/watch?v=-dfFyWqf9V4&ab_channel=GenesisRobotec",
          "pdf": "https://www.caceres.mt.gov.br/fotos_institucional_downloads/2.pdf",
          "model3d": "https://www.caceres.mt.gov.br/fotos_institucional_downloads/2.pdf",
        },
      ]
    },
  ];
}

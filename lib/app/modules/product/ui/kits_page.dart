import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:genesis_robotec/app/core/components/h.dart';
import 'package:genesis_robotec/app/core/components/stream_out.dart';
import 'package:genesis_robotec/app/core/components/w.dart';
import 'package:genesis_robotec/app/core/global_resources/global_resources.dart';
import 'package:genesis_robotec/app/core/theme/app_font_weight.dart';
import 'package:genesis_robotec/app/modules/product/product_model.dart';
import 'package:genesis_robotec/app/modules/product/ui/kit_page.dart';

import '../product_controller.dart';

class KitsPage extends StatefulWidget {
  const KitsPage({super.key});

  @override
  State<KitsPage> createState() => _KitsPageState();
}

class _KitsPageState extends State<KitsPage> {
  final ProductController _productController = ProductController();

  @override
  void initState() {
    _productController.getKits().then((_) async {
      await Future.delayed(const Duration(seconds: 1));
      FlutterNativeSplash.remove();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          backgroundColor: const Color(0xFFFFFFFF),
          body: StreamOut<List<ProductKit>>(
            stream: _productController.kits.listen,
            child: (_, kits) => StreamOut<ProductUtils>(
              stream: _productController.utils.listen,
              child: (_, utils) => _body(
                utils,
                kits
                    .where((e) => e.name
                        .toLowerCase()
                        .replaceAll(' ', '')
                        .contains(utils.controller.value.text.toLowerCase().replaceAll(' ', '')))
                    .toList(),
              ),
            ),
          )),
    );
  }

  Widget _body(ProductUtils utils, List<ProductKit> kits) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
      children: [
        const Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.dehaze),
        ),
        const H(16),
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            color: const Color(0xFFEBEFF2),
            child: TextField(
              controller: utils.controller,
              onChanged: (v) => _productController.utils.update(),
              cursorColor: const Color(0xFF3B3B3B),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 14,
                    color: const Color(0xFF7E8996),
                    fontWeight: AppFontWeight.light),
                hintText: 'Pesquisar Kits Robóticos',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF7E8996),
                  size: 28,
                ),
                suffixIcon: utils.controller.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          utils.controller.clear();
                          _productController.utils.update();
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.grey[600]!,
                        ),
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                fillColor: const Color(0xFFEBEFF2),
                hoverColor: const Color(0xFFEBEFF2),
                focusColor: const Color(0xFFEBEFF2),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
        const H(24),
        Text(
          'Kits Robóticos',
          style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 24,
              color: const Color(0xFF3B3B3B),
              fontWeight: AppFontWeight.bold),
        ),
        const H(24),
        if (kits.isEmpty)
          Row(
            children: [
              Icon(
                Icons.filter_alt_outlined,
                color: Colors.grey[500],
              ),
              const W(8),
              const Text('Não foram encontrados kits com esse filtro')
            ],
          )
        else
          for (var kit in kits) _kitItem(kit)
      ],
    );
  }

  Widget _kitItem(ProductKit kit) {
    return InkWell(
      onTap: () => push(context, KitPage(kit)),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 3, spreadRadius: 0.5)]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.maxFinite,
            color: const Color(0xFF34AC04),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 10,
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 180,
                      child: Stack(
                        children: [
                          Row(
                            children: kit.itens
                                .map((e) => Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: double.maxFinite,
                                              child: Image.network(
                                                'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          if (e != kit.itens.last)
                                            Container(
                                              height: double.maxFinite,
                                              width: 3,
                                              color: Colors.white,
                                            )
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                kit.favorite = !kit.favorite;
                                _productController.updateKits();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Icon(
                                  kit.favorite ? Icons.star : Icons.star_border,
                                  color: kit.favorite ? const Color(0xFFF2D027) : Colors.grey[500],
                                ),
                              ),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                      color: Color(0xFF34AC04),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kit.name,
                        style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: AppFontWeight.bold),
                      ),
                      const H(10),
                      Text(
                        'Nam porttitor blandit accumsan. Ut vel dictum sem, a pretium dui. In malesuada enim in dolor euismod, id commodo mi consectetur. Curabitur at vestibulum nisi.',
                        style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: AppFontWeight.light),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

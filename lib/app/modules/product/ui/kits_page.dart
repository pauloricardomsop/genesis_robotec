import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:genesis_robotec/app/core/components/h.dart';
import 'package:genesis_robotec/app/core/components/stream_out.dart';
import 'package:genesis_robotec/app/core/components/w.dart';
import 'package:genesis_robotec/app/core/global_resources/global_resources.dart';
import 'package:genesis_robotec/app/core/services/connectivity_service.dart';
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
    return StreamOut<List<Kit>>(
      stream: _productController.kits.listen,
      child: (_, kits) => StreamOut<ProductUtils>(
        stream: _productController.utils.listen,
        child: (_, utils) => _body(
          utils,
          kits
              .where((e) =>
                  e.name
                      .toLowerCase()
                      .replaceAll(' ', '')
                      .contains(utils.controller.value.text.toLowerCase().replaceAll(' ', '')) &&
                  (utils.searchOnlyFavorites ? e.favorite : true))
              .toList(),
        ),
      ),
    );
  }

  Widget _body(ProductUtils utils, List<Kit> kits) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: [
        const H(16),
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            color: const Color.fromARGB(255, 221, 223, 224),
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
                suffixIcon: SizedBox(
                  width: 72,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (utils.controller.text.isNotEmpty)
                        InkWell(
                          onTap: () {
                            utils.controller.clear();
                            _productController.utils.update();
                          },
                          child: Icon(
                            size: 28,
                            Icons.close,
                            color: Colors.grey[600]!,
                          ),
                        ),
                      if (utils.controller.text.isNotEmpty) const W(6),
                      InkWell(
                        onTap: () {
                          utils.searchOnlyFavorites = !utils.searchOnlyFavorites;
                          _productController.utils.update();
                        },
                        child: Icon(
                          utils.searchOnlyFavorites ? Icons.star : Icons.star_border,
                          size: 28,
                          color: utils.searchOnlyFavorites
                              ? const Color.fromARGB(255, 227, 220, 32)
                              : Colors.grey[600]!,
                        ),
                      ),
                      const W(10),
                    ],
                  ),
                ),
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

  Widget _kitItem(Kit kit) {
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
                          StreamOut(
                            stream: ConnectivyService.connection.listen,
                            child: (_, hasConnection) => Row(
                              children: kit.products
                                  .where((e) => hasConnection ? true : e.downloaded)
                                  .map((e) => Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: double.maxFinite,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: e.imageProvider, fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            if (e != kit.products.last)
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

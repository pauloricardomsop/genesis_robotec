import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:genesis_robotec/app/core/components/h.dart';
import 'package:genesis_robotec/app/core/components/stream_out.dart';
import 'package:genesis_robotec/app/core/global_resources/global_resources.dart';
import 'package:genesis_robotec/app/core/theme/app_font_weight.dart';
import 'package:genesis_robotec/app/modules/product/product_model.dart';
import 'package:genesis_robotec/app/modules/product/ui/product_page.dart';

import '../product_controller.dart';

class KitPage extends StatefulWidget {
  final ProductKit kit;

  const KitPage(this.kit, {super.key});

  @override
  State<KitPage> createState() => _KitPageState();
}

class _KitPageState extends State<KitPage> {
  final ProductController _productController = ProductController();

  @override
  void initState() {
    _productController.kit.add(widget.kit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: StreamOut<ProductKit>(
          stream: _productController.kit.listen,
          child: (_, kit) => ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                    onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios)),
              ),
              const H(24),
              Text(
                'Kit ${kit.name}',
                style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 24,
                    color: const Color(0xFF3B3B3B),
                    fontWeight: AppFontWeight.bold),
              ),
              const H(32),
              StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                children: kit.itens
                    .map((e) => StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 1,
                          child: _kitItem(e),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _kitItem(Product product) {
    return InkWell(
        onTap: () => push(context, ProductPage(product)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 7, spreadRadius: 1)],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: double.maxFinite,
              height: 100,
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: Image.network(
                          'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg',
                          fit: BoxFit.cover,
                        ),
                      )),
                  Expanded(
                      child: Container(
                    width: double.maxFinite,
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            product.name,
                            style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 16,
                                color: const Color(0xFF373F4A),
                                fontWeight: AppFontWeight.regular),
                          ),
                        ),
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              ),
                            )),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}

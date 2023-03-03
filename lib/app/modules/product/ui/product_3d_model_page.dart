import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/components/h.dart';
import 'package:genesis_robotec/app/core/components/stream_out%20copy.dart';
import 'package:genesis_robotec/app/modules/product/product_controller.dart';
import 'package:genesis_robotec/app/modules/product/product_model.dart';
import 'package:genesis_robotec/app/modules/product/product_repository.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Product3dModelPage extends StatefulWidget {
  final Product product;
  final List<ProductStep> steps;
  final ProductStep step;

  const Product3dModelPage(this.product, this.steps, this.step, {super.key});

  @override
  State<Product3dModelPage> createState() => _Product3dModelPageState();
}

class _Product3dModelPageState extends State<Product3dModelPage>
    with AutomaticKeepAliveClientMixin {
  late PageController page3DController;

  final ProductController _productController = ProductController();

  @override
  void initState() {
    if (!widget.step.completed) _setStepCompleted(widget.step);
    page3DController = PageController(initialPage: widget.steps.indexOf(widget.step));
    _productController.stepStream.add(widget.step);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: Colors.black,
        child: SafeArea(
          top: true,
          child: Scaffold(
              backgroundColor: const Color(0xFFE8F5E9),
              body: Stack(
                children: [
                  Column(
                    children: [_viewModel3dWidget(), _bottomMenu()],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.maxFinite,
                      height: 18,
                      color: Colors.white,
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Container _bottomMenu() {
    return Container(
      transform: Matrix4.translationValues(0, -5, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: StreamOut<ProductStep>(
          stream: _productController.stepStream.listen,
          child: (_, step) => Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Colors.white),
            width: double.maxFinite,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.product.name,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3B3B3B),
                        fontFamily: 'SpaceGrotesk',
                        fontWeight: FontWeight.bold)),
                const H(16),
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Passo ${widget.steps.indexOf(step) + 1}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                                fontFamily: 'SpaceGrotesk',
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          page3DController.previousPage(
                              duration: const Duration(milliseconds: 500), curve: Curves.ease);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 20,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          page3DController.nextPage(
                              duration: const Duration(milliseconds: 500), curve: Curves.ease);
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          size: 20,
                          color: Colors.grey[800],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _viewModel3dWidget() {
    return Expanded(
      child: PageView(
        controller: page3DController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (i) {
          _setStepCompleted(widget.steps[i]);
          _productController.stepStream.add(widget.steps[i]);
        },
        children: widget.steps
            .map(
              (e) => ModelViewer(
                key: Key(e.toString()),
                backgroundColor: Colors.green[50]!,
                src: '${e.downloaded ? 'file:' : ''}${e.model}',
                alt: widget.product.name,
              ),
            )
            .toList(),
      ),
    );
  }

  void _setStepCompleted(ProductStep step) {
    step.completed = true;
    for (var kit in ProductRepository.getKits()) {
      if (kit.name == widget.product.kitName) {
        kit.save();
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/components/h.dart';
import 'package:genesis_robotec/app/core/components/stream_out.dart';
import 'package:genesis_robotec/app/core/components/w.dart';
import 'package:genesis_robotec/app/core/global_resources/global_resources.dart';
import 'package:genesis_robotec/app/core/services/connectivity_service.dart';
import 'package:genesis_robotec/app/core/theme/app_font_weight.dart';
import 'package:genesis_robotec/app/modules/product/product_controller.dart';
import 'package:genesis_robotec/app/modules/product/product_model.dart';
import 'package:genesis_robotec/app/modules/product/ui/product_model_page.dart';
import 'package:genesis_robotec/app/modules/product/ui/product_pdf_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage(this.product, {super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductController _productController = ProductController();

  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: '-dfFyWqf9V4',
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  @override
  void initState() {
    _productController.product.add(widget.product);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: StreamOut(
          stream: _productController.product.listen,
          child: (_, product) => ListView(
            children: [
              Container(
                width: double.maxFinite,
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(image: widget.product.imageProvider, fit: BoxFit.fill)),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () => _productController.onProductDownload(context, product),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: product.downloaded ? Colors.green : Colors.white),
                            child: Icon(
                              Icons.download,
                              color: product.downloaded ? Colors.white : Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0, -26, 0),
                padding: const EdgeInsets.all(16),
                width: double.maxFinite,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32), topRight: Radius.circular(32))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                              fontSize: 28,
                              color: Color(0xFF3B3B3B),
                              fontWeight: FontWeight.w900,
                              fontFamily: 'SpaceGrotesk'),
                        ),
                        InkWell(
                          onTap: () {
                            product.favorite = !product.favorite;
                            _productController.updateKits();
                          },
                          child: Icon(
                            product.favorite ? Icons.star : Icons.star_border,
                            size: 32,
                            color: product.favorite ? const Color(0xFFF2D027) : Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    const H(16),
                    Text(
                      'Nam porttitor blandit accumsan. Ut vel dictum sem, a pretium dui. In malesuada enim in dolor euismod, id commodo mi consectetur. Curabitur at vestibulum nisi.',
                      style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 16,
                          fontWeight: AppFontWeight.regular,
                          color: const Color(0xFF3B3B3B)),
                    ),
                    const H(24),
                    _pdfButton(),
                    StreamOut(
                        stream: ConnectivyService.connection.listen,
                        child: (_, hasConnection) => hasConnection
                            ? Column(
                                children: [
                                  const H(24),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: YoutubePlayer(
                                      controller: _controller,
                                      showVideoProgressIndicator: true,
                                      progressColors: const ProgressBarColors(
                                        playedColor: Colors.red,
                                        handleColor: Colors.redAccent,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Container()),
                    const H(24),
                    const Text(
                      'Passo a passo',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF3B3B3B),
                          fontWeight: FontWeight.w800,
                          fontFamily: 'SpaceGrotesk'),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('${(product.stepsPercentagem * 10).toInt()}%',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xFF3B3B3B),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SpaceGrotesk')),
                    ),
                    const H(6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE4E4E4),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: LinearProgressIndicator(
                            backgroundColor: const Color(0xFFE4E4E4),
                            valueColor: const AlwaysStoppedAnimation(Color(0xFFFFD500)),
                            minHeight: 16,
                            value: product.stepsPercentagem,
                          ),
                        ),
                      ),
                    ),
                    const H(16),
                    for (var step in product.steps)
                      InkWell(
                        onTap: () =>
                            push(context, const ProductModelPage('Passo tal', 'file:/step.model')),
                        child: IgnorePointer(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(8),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: const Color(0xFF707070))),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: step.completed,
                                  onChanged: (v) {},
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: const BorderSide(width: 0.1)),
                                ),
                                const W(4),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Text('Passo ${product.steps.indexOf(step) + 1}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF3B3B3B),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'SpaceGrotesk')),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _pdfButton() {
    return InkWell(
      onTap: () => push(context, ProductPdfPage(widget.product)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color(0xFF1F6DD2)),
        child: Row(
          children: [
            Text(
              'Passo a passo PDF',
              style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 16,
                  fontWeight: AppFontWeight.regular,
                  color: Colors.white),
            ),
            const Spacer(),
            const Icon(
              Icons.archive_outlined,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

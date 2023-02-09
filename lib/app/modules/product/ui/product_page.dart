import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/components/h.dart';
import 'package:genesis_robotec/app/core/components/stream_out.dart';
import 'package:genesis_robotec/app/core/components/w.dart';
import 'package:genesis_robotec/app/core/theme/app_font_weight.dart';
import 'package:genesis_robotec/app/modules/product/product_controller.dart';
import 'package:genesis_robotec/app/modules/product/product_model.dart';
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
    return Scaffold(
      body: StreamOut(
        stream: _productController.product.listen,
        child: (_, product) => CustomScrollView(
          slivers: [
            SliverAppBar.large(
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://miro.medium.com/max/640/0*i1v1In2Tn4Stnwnl.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size(double.maxFinite, 24),
                child: Container(
                  width: double.maxFinite,
                  height: 24,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(36), topRight: Radius.circular(36))),
                ),
              ),
              leading: InkWell(
                  onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios)),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
                  width: double.maxFinite,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.name,
                            style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 32,
                                fontWeight: AppFontWeight.bold,
                                color: const Color(0xFF3B3B3B)),
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
                      Row(
                        children: [
                          _button(
                              onTap: () {},
                              title: 'Passo a\npasso PDF',
                              icon: Icons.archive_outlined,
                              color: const Color(0xFF1F6DD2)),
                          const W(32),
                          _button(
                              onTap: () {},
                              title: 'Passo a\npasso 3D',
                              icon: Icons.view_module_sharp,
                              color: const Color(0xFFF25244)),
                        ],
                      ),
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
                      ),
                    ],
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  Expanded _button(
      {required Function() onTap,
      required String title,
      required IconData icon,
      required Color color}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: color),
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 16,
                      fontWeight: AppFontWeight.regular,
                      color: Colors.white),
                ),
                const Spacer(),
                Icon(
                  icon,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ProductModelPage extends StatefulWidget {
  final String title;
  final String src;

  const ProductModelPage(this.title, this.src, {super.key});

  @override
  State<ProductModelPage> createState() => _ProductModelPageState();
}

class _ProductModelPageState extends State<ProductModelPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
              'Passo ',
              style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'SpaceGrotesk'),
            ),
            backgroundColor: const Color(0xFF3B3B3B)),
        body: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.grey[100]!,
            width: double.maxFinite,
            height: double.maxFinite,
            child: ModelViewer(
              backgroundColor: Colors.grey[100]!,
              src:
                  'https://firebasestorage.googleapis.com/v0/b/genesis-robotec.appspot.com/o/activities%2F00_bloco_energia_solar%2Fmodel.glb?alt=media&token=6fee4e57-38c3-4b10-9bc0-2bc0744bf736',
              ar: false,
            ),
          ),
        ),
      ),
    );
  }
}

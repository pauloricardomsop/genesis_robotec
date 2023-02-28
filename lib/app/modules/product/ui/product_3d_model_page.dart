import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/components/w.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Product3dModelPage extends StatefulWidget {
  final String title;
  final String src;
  final bool hasNext;

  const Product3dModelPage(this.title, this.src, this.hasNext, {super.key});

  @override
  State<Product3dModelPage> createState() => _Product3dModelPageState();
}

class _Product3dModelPageState extends State<Product3dModelPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: Colors.black,
        child: SafeArea(
          top: true,
          child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                title: Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 24, color: Colors.white, fontFamily: 'SpaceGrotesk'),
                ),
                automaticallyImplyLeading: true,
                leading: InkWell(
                  onTap: () => Navigator.pop(context, false),
                  child: const Icon(Icons.arrow_back),
                ),
                actions: [
                  if (widget.hasNext)
                    InkWell(
                      onTap: () => Navigator.pop(context, true),
                      child: Container(
                        width: 168,
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(24)),
                        child: Row(
                          children: const [
                            Text('Próximo Passo',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF3B3B3B),
                                    fontFamily: 'SpaceGrotesk',
                                    fontWeight: FontWeight.bold)),
                            W(8),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                ],
                backgroundColor: const Color(0xFF3B3B3B)),
            body: ModelViewer(
              backgroundColor: Colors.green[50]!,
              src: widget.src,
              alt: widget.title,
            ),
          ),
        ),
      ),
    );
  }
}

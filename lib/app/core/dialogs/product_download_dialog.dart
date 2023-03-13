import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/components/h.dart';
import 'package:genesis_robotec/app/core/components/stream_out%20copy.dart';
import 'package:genesis_robotec/app/modules/product/product_controller.dart';
import 'package:genesis_robotec/app/modules/product/product_model.dart';

class ProductDownloadDialog extends StatefulWidget {
  const ProductDownloadDialog({super.key});

  @override
  State<ProductDownloadDialog> createState() => _ProductDownloadDialogState();
}

class _ProductDownloadDialogState extends State<ProductDownloadDialog> {
  final ProductController _productController = ProductController();

  @override
  void initState() {
    _productController.downloadStream.add(ProductDownload());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SimpleDialog(
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        children: [
          StreamOut<ProductDownload>(
            stream: _productController.downloadStream.listen,
            child: (_, download) => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Realizando download do kit, aguarde.',
                    style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 18,
                        color: Color(0xFF3B3B3B),
                        fontWeight: FontWeight.bold),
                  ),
                  const H(16),
                  Text(
                    download.title,
                    style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 14,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500),
                  ),
                  const H(8),
                  LinearProgressIndicator(
                    color: const Color(0xFF34AC04),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF34AC04)),
                    backgroundColor: const Color(0xFF34AC04).withOpacity(0.1),
                    value: download.current == 0 ? 0 : download.current / download.length,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

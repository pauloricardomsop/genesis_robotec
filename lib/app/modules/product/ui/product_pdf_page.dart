import 'package:flutter/material.dart';
import 'package:genesis_robotec/app/core/components/loading%20copy.dart';
import 'package:genesis_robotec/app/modules/product/product_model.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class ProductPdfPage extends StatefulWidget {
  final Product product;

  const ProductPdfPage(this.product, {super.key});

  @override
  State<ProductPdfPage> createState() => _ProductPdfPageState();
}

class _ProductPdfPageState extends State<ProductPdfPage> {
  late PdfControllerPinch pdfPinchController;

  @override
  void initState() {
    if (widget.product.downloaded) {
      pdfPinchController = PdfControllerPinch(document: PdfDocument.openFile(widget.product.pdf));
    } else {
      pdfPinchController =
          PdfControllerPinch(document: PdfDocument.openData(InternetFile.get(widget.product.pdf)));
    }

    super.initState();
  }

  @override
  void dispose() {
    pdfPinchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: true,
        child: Scaffold(
          appBar: AppBar(
              title: const Text(
                'Passo a Passo em PDF',
                style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'SpaceGrotesk'),
              ),
              backgroundColor: const Color(0xFF3B3B3B)),
          body: PdfViewPinch(
            controller: pdfPinchController,
            builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
              options: const DefaultBuilderOptions(
                loaderSwitchDuration: Duration(seconds: 1),
              ),
              documentLoaderBuilder: (_) => const Center(child: Loading()),
              pageLoaderBuilder: (_) => const Center(child: Loading()),
              errorBuilder: (_, error) => Center(child: Text(error.toString())),
            ),
          ),
        ),
      ),
    );
  }
}

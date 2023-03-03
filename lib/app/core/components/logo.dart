import 'package:flutter/cupertino.dart';

class Logo extends StatelessWidget {
  final double size;

  const Logo(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/launcher/logo.png',
      width: size,
      height: size,
    );
  }
}

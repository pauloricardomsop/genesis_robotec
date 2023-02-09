// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';

class ProductKit {
  final String name;
  bool favorite;
  final List<Product> itens;
  ProductKit({required this.name, required this.itens, required this.favorite});

  factory ProductKit.fromMap(Map<String, dynamic> map) {
    return ProductKit(
      name: map['name'] as String,
      favorite: map['favorite'] as bool,
      itens: map['itens'].map<Product>((e) => Product.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'favorite': favorite,
      'itens': itens.map((x) => x.toMap()).toList(),
    };
  }
}

class Product {
  final String name;
  final String image;
  bool favorite;
  final String video;
  final String pdf;
  final String model3d;

  Product({
    required this.name,
    required this.image,
    required this.favorite,
    required this.video,
    required this.pdf,
    required this.model3d,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      image: map['image'] as String,
      favorite: map['favorite'] as bool,
      video: map['video'] as String,
      pdf: map['pdf'] as String,
      model3d: map['model3d'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'favorite': favorite,
      'video': video,
      'pdf': pdf,
      'model3d': model3d,
    };
  }
}

class ProductUtils {
  TextEditingController controller = TextEditingController();
}

import 'dart:convert';

class ProductKit {
  final String title;
  final List<ProductItem> itens;
  ProductKit({required this.title, required this.itens});

  factory ProductKit.fromMap(Map<String, dynamic> map) {
    return ProductKit(
      title: map['title'],
      itens: map['title'],
    );
  }
}

class ProductItem {
  final String title;
  final String image;
  final bool favorite;

  ProductItem(
      {required this.title, required this.image, required this.favorite});

  ProductItem fromJson(String json) => ProductItem.fromMap(jsonDecode(json));

  factory ProductItem.fromMap(Map<String, dynamic> map) {
    return ProductItem(
      title: map['title'],
      image: map['image'],
      favorite: map['favorite'],
    );
  }
}

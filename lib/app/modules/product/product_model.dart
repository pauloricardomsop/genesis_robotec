class ProductKit {
  final String name;
  final bool favorite;
  final List<Product> itens;
  ProductKit({required this.name, required this.itens, required this.favorite});

  factory ProductKit.fromMap(Map<String, dynamic> map) {
    return ProductKit(
      name: map['name'],
      favorite: map['favorite'],
      itens: map['itens'].map<Product>((e) => Product.fromMap(e)).toList(),
    );
  }
}

class Product {
  final String name;
  final String image;
  final bool favorite;
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
      name: map['name'],
      image: map['image'],
      favorite: map['favorite'],
      video: map['video'],
      pdf: map['pdf'],
      model3d: map['model3d'],
    );
  }
}

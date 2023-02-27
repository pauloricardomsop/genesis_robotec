import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Kit extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final List<Product> products;
  @HiveField(3)
  bool favorite = false;
  @HiveField(4)
  int version;
  @HiveField(5)
  bool downloaded = false;

  Kit(
      {required this.name,
      required this.description,
      required this.products,
      required this.version});

  factory Kit.fromJson(Map<String, dynamic> json) {
    return Kit(
      name: json['name'],
      description: json['description'],
      version: json['version'],
      products: json['products'].map<Product>((v) => Product.fromJson(v)).toList(),
    );
  }
}

@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String description;
  @HiveField(2)
  String pdf;
  @HiveField(3)
  String image;
  @HiveField(4)
  String model;
  @HiveField(5)
  String video;
  @HiveField(6)
  List<Step> steps;
  @HiveField(7)
  bool favorite = false;
  @HiveField(8)
  bool downloaded = false;
  @HiveField(9)
  String kitName;

  dynamic get imageProvider => downloaded ? FileImage(File(image)) : NetworkImage(image);

  Product(
      {required this.name,
      required this.description,
      required this.pdf,
      required this.image,
      required this.model,
      required this.video,
      required this.kitName,
      required this.steps});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        name: json['name'],
        description: json['description'],
        pdf: json['pdf'],
        image: json['image'],
        model: json['model'],
        video: json['video'],
        steps: json['steps'].map<Step>((v) => Step(v)).toList(),
        kitName: json['kitName']);
  }

  int get stepsCompletedLength => steps.where((e) => e.completed).toList().length;
  double get stepsPercentagem =>
      stepsCompletedLength == 0 ? 0.0 : (stepsCompletedLength ~/ steps.length).toDouble();
}

@HiveType(typeId: 2)
class Step extends HiveObject {
  @HiveField(0)
  String model;
  @HiveField(1)
  bool completed = false;
  @HiveField(2)
  bool downloaded = false;
  Step(this.model);
}

class ProductUtils {
  TextEditingController controller = TextEditingController();
}

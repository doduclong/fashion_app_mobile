import 'package:fashion_app/app/models/category.dart';
import 'package:fashion_app/app/models/product/gallery_product.dart';

class Product{
  int? id;
  String? name;
  int? price;
  String? describe;
  Category? category;
  List<GalleryProduct>? galleries;

  Product({this.id, this.name, this.price, this.describe, this.category, this.galleries});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    describe: json["describe"],
    category:json["category"] != null ? Category.fromJson(json["category"]) : null,
    galleries: List<GalleryProduct>.from(json['galleries']
        .map((value) => GalleryProduct.fromJson(value))),
  );
}
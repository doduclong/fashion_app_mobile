import 'package:fashion_app/app/models/category.dart';
import 'package:fashion_app/app/models/product/gallery_product.dart';
import 'package:fashion_app/app/models/product/size_product.dart';

class Product{
  int? id;
  String? name;
  int? price;
  String? describe;
  Category? category;
  List<GalleryProduct>? galleries;
  List<SizeProduct>? sizes;

  Product({this.id, this.name, this.price, this.describe, this.category, this.galleries, this.sizes});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    describe: json["describe"],
    category:json["category"] != null ? Category.fromJson(json["category"]) : null,
    galleries: List<GalleryProduct>.from(json['galleries']
        .map((value) => GalleryProduct.fromJson(value))),
    sizes: List<SizeProduct>.from(json['sizes']
        .map((value) => SizeProduct.fromJson(value))),
  );
}
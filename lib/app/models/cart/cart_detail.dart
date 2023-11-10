import 'package:fashion_app/app/models/product/product.dart';

class CartDetail{
  int? id;
  Product? product;
  int quantity;

  CartDetail({this.id, this.product, required this.quantity});

  factory CartDetail.fromJson(Map<String, dynamic> json) => CartDetail(
    id: json["id"],
    product: Product.fromJson(json["product"]),
    quantity: json["quantity"],
  );
}
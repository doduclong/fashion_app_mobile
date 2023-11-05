import 'package:fashion_app/app/models/product/product.dart';

class CartDetail{
  Product? product;
  int quantity;

  CartDetail({required this.product, required this.quantity});

  factory CartDetail.fromJson(Map<String, dynamic> json) => CartDetail(
    product: Product.fromJson(json["product"]),
    quantity: json["quantity"],
  );
}
import 'package:fashion_app/app/models/product/product.dart';

class CartDetail{
  int? id;
  Product? product;
  int quantity;
  String size;

  CartDetail({this.id, this.product, required this.quantity, required this.size});

  factory CartDetail.fromJson(Map<String, dynamic> json) => CartDetail(
    id: json["id"],
    product: Product.fromJson(json["product"]),
    quantity: json["quantity"],
    size:  json["size"]
  );
}
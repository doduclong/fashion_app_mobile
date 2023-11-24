import 'package:fashion_app/app/models/product/gallery_product.dart';

class OrderDetail{
  int? id;
  String? productName;
  int? price;
  List<GalleryProduct>? galleries;
  int? quantity;
  String? size;

  OrderDetail({
      this.id, this.productName,this.price, this.galleries, this.quantity, this.size});

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    id: json["id"],
    productName: json["productName"],
    price: json["price"],
    galleries: List<GalleryProduct>.from(json['galleries']
        .map((value) => GalleryProduct.fromJson(value))),
    quantity: json["quantity"],
    size: json["size"],
  );
}
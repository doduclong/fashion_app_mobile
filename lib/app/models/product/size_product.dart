class SizeProduct{
  int? id;
  String? size;
  int? quantity;


  SizeProduct({this.id, this.size, this.quantity});

  factory SizeProduct.fromJson(Map<String, dynamic> json) => SizeProduct(
    id: json["id"],
    size: json["size"],
    quantity: json["quantity"]
  );

  Map toJson() => {
    'size': size,
    'quantity': quantity,
  };
}
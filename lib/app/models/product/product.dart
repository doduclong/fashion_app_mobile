class Product{
  int? id;
  String? name;
  int? price;
  String? description;
  String? branch;
  int? quantity;
  String? category;

  Product({this.id, this.name, this.price, this.description, this.branch,
      this.quantity, this.category});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    description: json["description"],
    branch: json["branch"],
    quantity: json["quantity"],
    category: json["category"],
  );
}
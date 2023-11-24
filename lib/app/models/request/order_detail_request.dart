class OrderDetailRequest{
  String name;
  int quantity;
  String size;

  OrderDetailRequest({required this.name,required this.quantity,required this.size});

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'quantity': quantity,
        'size': size,
      };
}
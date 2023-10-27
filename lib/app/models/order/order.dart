class Order{
  int? id;
  int? totalMoney;
  String? timeOrder;
  String? payment;
  String? note;
  String? fullName;
  String? address;
  String? phoneNumber;
  String? status;

  Order({this.id, this.totalMoney, this.timeOrder, this.payment, this.note,
      this.fullName, this.address, this.phoneNumber, this.status});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    totalMoney: json["totalMoney"],
    timeOrder: json["timeOrder"],
    payment: json["payment"],
    note: json["note"],
    fullName: json["fullName"],
    address: json["address"],
    phoneNumber: json["phoneNumber"],
    status: json["status"],
  );
}
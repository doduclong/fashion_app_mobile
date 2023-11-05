class DeliveryAddressModel{
  int? id;
  String? address;
  String? fullName;
  String? phoneNumber;

  DeliveryAddressModel({this.id, this.address, this.fullName, this.phoneNumber});

  factory DeliveryAddressModel.fromJson(Map<String, dynamic> json) => DeliveryAddressModel(
    id: json["id"],
    address: json["address"],
    fullName: json["fullName"],
    phoneNumber: json["phoneNumber"],
  );
}
import 'package:fashion_app/app/models/order/order_detail.dart';

class Order{
  int? id;
  List<OrderDetail>? listOrderDetail;
  int? totalMoney;
  String? note;
  String? payment;
  String? receiverName;
  String? receiverPhone;
  String? receiverAddress;
  String? timeOrder;
  String? status;

  Order({this.id,this.listOrderDetail, this.totalMoney, this.timeOrder, this.payment, this.note,
      this.receiverName, this.receiverAddress, this.receiverPhone, this.status});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    listOrderDetail: List<OrderDetail>.from(json['listOrderDetail']
        .map((value) => OrderDetail.fromJson(value))),
    totalMoney: json["total"],
    timeOrder: json["timeOrder"],
    payment: json["payment"],
    note: json["note"],
    receiverName: json["receiverName"],
    receiverAddress: json["receiverAddress"],
    receiverPhone: json["receiverPhone"],
    status: json["status"],
  );
}
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fashion_app/app/data/constant/environment.dart';
import 'package:fashion_app/app/models/order/order.dart';
import 'package:fashion_app/app/models/request/order_detail_request.dart';
import 'package:fashion_app/app/models/response/response_object.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/core/values/app_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class OrderClient {
  List<String> ids = [];
  late Dio dio;

  OrderClient() {
    dio = Dio();
    initialize();
  }

  void initialize() {
    // Any common initialization code for the Dio instance
    // can be implemented here
    //interceptor();
    dio.options.baseUrl = Environment.API_FASHION_APP;
    dio.options.connectTimeout = const Duration(milliseconds: AppValue.timeout);
    dio.options.receiveTimeout = const Duration(milliseconds: AppValue.timeout);
  }

  Future order(List<OrderDetailRequest> orderDetails, String payment, String note, String fullName, String address, String phoneNumber, List<int> listSelectedCartDetailId);
  Future getOrdersOfUser();

  Future getOrders();
  
  Future updateOrderStatus(int orderId, String status);
}

class OrderApi extends OrderClient{
  static const orderEndpoint = "/order";


  Map<String, dynamic> headers = {'Authorization': 'Bearer ${Get
      .find<LoginController>()
      .storedToken
      .value}'};


  @override
  Future order(List<OrderDetailRequest> orderDetails, String payment, String note, String fullName, String address, String phoneNumber, List<int> listSelectedCartDetailId) async{
    final requestBody = {
      //"listOrderProduct": orderDetails,
      "listOrderProduct": List<Map<String, dynamic>>.from(orderDetails.map((data) => data.toJson())),
      "payment": payment,
      "note": note,
      "receiverName" : fullName,
      "receiverAddress" : address,
      "receiverPhone" : phoneNumber,
      "listSelectedCartDetailId": listSelectedCartDetailId
    };

    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.post(
          '$orderEndpoint/create',
          options: Options(headers: headers),
          data: requestBody,
        );
        if (response.statusCode == 200) {
          return ServerResponse.success;
        } else {
          debugPrint("create delivery address: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("create delivery address: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } catch(e) {
      print(e);
      return ServerResponse.connectionFailed;
    }
  }

  @override
  Future getOrdersOfUser() async{
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.get(
          '$orderEndpoint/user',
          options: Options(headers: headers),
        );
        ResponseObject responseObject = ResponseObject.fromJson(response.data);
        if (response.statusCode == 200) {
          List<Order> datas = List<Order>.from(responseObject.data.map((jsonData) => Order.fromJson(jsonData)));
          return datas;
        } else {
          debugPrint("get orders of user: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("get  orders of user: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("get  orders of user: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

  @override
  Future getOrders() async{
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.get(
          '$orderEndpoint/',
          options: Options(headers: headers),
        );
        ResponseObject responseObject = ResponseObject.fromJson(response.data);
        if (response.statusCode == 200) {
          List<Order> datas = List<Order>.from(responseObject.data.map((jsonData) => Order.fromJson(jsonData)));
          return datas;
        } else {
          debugPrint("get orders of user: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("get  orders of user: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("get  orders of user: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

  @override
  Future updateOrderStatus(int orderId, String status) async{
    final requestBody = {
      //"listOrderProduct": orderDetails,
      "orderId": orderId,
      "status": status,
    };

    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.post(
          '$orderEndpoint/update-status',
          options: Options(headers: headers),
          data: requestBody,
        );
        if (response.statusCode == 200) {
          return ServerResponse.success;
        } else {
          debugPrint("update order status: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("update order status: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } catch(e) {
      print(e);
      return ServerResponse.connectionFailed;
    }
  }
}
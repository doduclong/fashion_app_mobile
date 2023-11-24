import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fashion_app/app/data/constant/environment.dart';
import 'package:fashion_app/app/models/request/order_detail_request.dart';
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

  Future order(List<OrderDetailRequest> orderDetails, String payment, String note, String fullName, String address, String phoneNumber);

}

class OrderApi extends OrderClient{
  static const orderEndpoint = "/order";


  Map<String, dynamic> headers = {'Authorization': 'Bearer ${Get
      .find<LoginController>()
      .storedToken
      .value}'};


  @override
  Future order(List<OrderDetailRequest> orderDetails, String payment, String note, String fullName, String address, String phoneNumber) async{
    final requestBody = {
      //"listOrderProduct": orderDetails,
      "listOrderProduct": List<Map<String, dynamic>>.from(orderDetails.map((data) => data.toJson())),
      "payment": payment,
      "note": note,
      "receiverName" : fullName,
      "receiverAddress" : address,
      "receiverPhone" : phoneNumber,
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


}
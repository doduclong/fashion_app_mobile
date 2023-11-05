import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fashion_app/app/data/constant/environment.dart';
import 'package:fashion_app/app/models/delivery_address_model.dart';
import 'package:fashion_app/app/models/response/response_object.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/core/values/app_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class DeliveryAddressClient {
  List<String> ids = [];
  late Dio dio;

  DeliveryAddressClient() {
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

  Future getDeliveryAddresses();

  Future createDeliveryAddress(String address, String fullName, String phoneNumber);
}

class DeliveryAddressApi extends DeliveryAddressClient{
  static const deliveryAddressEndpoint = "/delivery-address";


  Map<String, dynamic> headers = {'Authorization': 'Bearer ${Get
      .find<LoginController>()
      .storedToken
      .value}'};

  @override
  Future getDeliveryAddresses() async{
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.get(
          deliveryAddressEndpoint,
          options: Options(headers: headers),
        );
        ResponseObject responseObject = ResponseObject.fromJson(response.data);
        if (response.statusCode == 200) {
          List<DeliveryAddressModel> datas = List<DeliveryAddressModel>.from(responseObject.data.map((jsonData) => DeliveryAddressModel.fromJson(jsonData)));
          return datas;
        } else {
          debugPrint("get delivery addresses: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("get delivery addresses: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("get delivery addresses: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

  @override
  Future createDeliveryAddress(String address, String fullName, String phoneNumber) async{
    final requestBody = {
      "address": address,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
    };

    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.post(
          deliveryAddressEndpoint,
          options: Options(headers: headers),
          data: requestBody,
        );
        ResponseObject responseObject = ResponseObject.fromJson(response.data);
        if (response.statusCode == 200) {
          return  ServerResponse.success;
        } else {
          debugPrint("create delivery address: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("create delivery address: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("create delivery address: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fashion_app/app/data/constant/environment.dart';
import 'package:fashion_app/app/models/response/response_object.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/core/values/app_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginClient {
  List<String> ids = [];
  //LoginApi loginApi = Get.find<LoginApi>();
  late Dio dio;

  LoginClient() {
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

  Future authenticate(String username, String password);
}

class LoginApi extends LoginClient{
  static const authenticateEndpoint = "/authenticate";

  @override
  Future authenticate(String username, String password) async{
    final requestBody = {
      "username": username,
      "password": password,
    };

    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.post(
          authenticateEndpoint,
          data: requestBody,
        );
        if (response.statusCode == 200) {
          Get.find<LoginController>().storedToken.value = response.data["token"];
          debugPrint("Login: Success!");
          return  ServerResponse.success;
        } else {
          debugPrint("Login: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("Login: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("Login: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

}
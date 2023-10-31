import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fashion_app/app/data/constant/environment.dart';
import 'package:fashion_app/app/models/response/response_object.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/models/user_model.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/core/values/app_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class UserInfoClient {
  List<String> ids = [];
  late Dio dio;

  UserInfoClient() {
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

  Future getUserInfo();
}

class UserInfoApi extends UserInfoClient{
  static const userInfoEndpoint = "/user/info";


  Map<String, dynamic> headers = {'Authorization': 'Bearer ${Get
      .find<LoginController>()
      .storedToken
      .value}'};

  @override
  Future getUserInfo() async{
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.get(
          userInfoEndpoint,
          options: Options(headers: headers),
        );
        ResponseObject responseObject = ResponseObject.fromJson(response.data);
        if (response.statusCode == 200) {
          UserModel data = UserModel.fromJson(responseObject.data);
          return data;
        } else {
          debugPrint("get user info: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("get user info: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("get user info: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

}
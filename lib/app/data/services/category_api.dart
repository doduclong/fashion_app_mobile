import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fashion_app/app/data/constant/environment.dart';
import 'package:fashion_app/app/models/category.dart';
import 'package:fashion_app/app/models/response/response_object.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/core/values/app_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

abstract class CategoryClient {
  List<String> ids = [];
  late Dio dio;

  CategoryClient() {
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

  Future getCategories();

  Future createCategory(String name);

}

class CategoryApi extends CategoryClient{
  static const categoryEndpoint = "/category";


  Map<String, dynamic> headers = {'Authorization': 'Bearer ${Get
      .find<LoginController>()
      .storedToken
      .value}'};

  @override
  Future getCategories() async{
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.get(
          '$categoryEndpoint/',
          options: Options(headers: headers),
        );
        ResponseObject responseObject = ResponseObject.fromJson(response.data);
        if (response.statusCode == 200) {
          List<Category> datas = List<Category>.from(responseObject.data.map((jsonData) => Category.fromJson(jsonData)));
          return datas;
        } else {
          debugPrint("get products: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("get products: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("get products: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

  @override
  Future createCategory(String name) async{
    final requestBody = {
      "name": name,
    };

    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.post(
          '$categoryEndpoint/create',
          options: Options(headers: headers),
          data: requestBody,
        );
        if (response.statusCode == 200) {
          return  ServerResponse.success;
        } else {
          debugPrint("create category: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("create category: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("create category: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

}
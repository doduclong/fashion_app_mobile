import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fashion_app/app/data/constant/environment.dart';
import 'package:fashion_app/app/models/product/product.dart';
import 'package:fashion_app/app/models/response/response_object.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/core/values/app_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ProductClient {
  List<String> ids = [];
  late Dio dio;

  ProductClient() {
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

  Future getProducts();

  Future searchProduct(String searchText);

  Future searchProductByKeywords(List<String> keywords);

  Future getProductById(int id);
}

class ProductApi extends ProductClient{
  static const productEndpoint = "/product";


  Map<String, dynamic> headers = {'Authorization': 'Bearer ${Get
      .find<LoginController>()
      .storedToken
      .value}'};

  @override
  Future getProducts() async{
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.get(
          '$productEndpoint/getAll',
          options: Options(headers: headers),
        );
        ResponseObject responseObject = ResponseObject.fromJson(response.data);
        if (response.statusCode == 200) {
          List<Product> datas = List<Product>.from(responseObject.data.map((jsonData) => Product.fromJson(jsonData)));
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
  Future searchProduct(String searchText) async{
    final requestParam = {
      "searchText": searchText,
    };
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.get(
          '$productEndpoint/search',
          options: Options(headers: headers),
          queryParameters: requestParam

        );
        ResponseObject responseObject = ResponseObject.fromJson(response.data);
        if (response.statusCode == 200) {
          List<Product> datas = List<Product>.from(responseObject.data.map((jsonData) => Product.fromJson(jsonData)));
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
  Future getProductById(int id) async{
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.get(
            '$productEndpoint/$id',
            options: Options(headers: headers),

        );
        ResponseObject responseObject = ResponseObject.fromJson(response.data);
        if (response.statusCode == 200) {
          Product data = Product.fromJson(responseObject.data);
          return data;
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
  Future searchProductByKeywords(List<String> keywords) async{
    final requestParam = {
      "keywords": keywords,
    };
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.get(
            '$productEndpoint/search/keywords',
            options: Options(headers: headers),
            queryParameters: requestParam

        );
        ResponseObject responseObject = ResponseObject.fromJson(response.data);
        if (response.statusCode == 200) {
          List<Product> datas = List<Product>.from(responseObject.data.map((jsonData) => Product.fromJson(jsonData)));
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

}
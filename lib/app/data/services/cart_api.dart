import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fashion_app/app/data/constant/environment.dart';
import 'package:fashion_app/app/models/cart/cart_detail.dart';
import 'package:fashion_app/app/models/response/response_object.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/core/values/app_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CartClient {
  List<String> ids = [];
  late Dio dio;

  CartClient() {
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

  Future getCartDetail();

  Future getQuantityItem();

  Future addProductToCart(String nameProduct, int quantity, String size);

  Future removeProductFromCart(int id);

  Future updateQuantity(int cartDetailId, int quantity);
}

class CartApi extends CartClient{
  static const cartEndpoint = "/cart";


  Map<String, dynamic> headers = {'Authorization': 'Bearer ${Get
      .find<LoginController>()
      .storedToken
      .value}'};

  @override
  Future getCartDetail() async{
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.get(
          '$cartEndpoint/',
          options: Options(headers: headers),
        );
        ResponseObject responseObject = ResponseObject.fromJson(response.data);
        if (response.statusCode == 200) {
          List<CartDetail> datas = List<CartDetail>.from(responseObject.data["listCartDetail"].map((jsonData) => CartDetail.fromJson(jsonData)));
          return datas;
        } else {
          debugPrint("get cart: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("get cart: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("get cart: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

  @override
  Future addProductToCart(String nameProduct, int quantity, String size) async{
    final requestBody = {
      "name": nameProduct,
      "quantity": quantity,
      "size" : size,
    };

    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.post(
          '$cartEndpoint/add-product',
          options: Options(headers: headers),
          data: requestBody,
        );
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

  @override
  Future updateQuantity(int cartDetailId, int quantity) async{
    final requestBody = {
      "cartDetailId": cartDetailId,
      "quantity": quantity,
    };

    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.post(
          '$cartEndpoint/update-quantity',
          options: Options(headers: headers),
          data: requestBody,
        );
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

  @override
  Future removeProductFromCart(int id) async{
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.delete(
          '$cartEndpoint/remove-product/$id',
          options: Options(headers: headers),
        );
        if (response.statusCode == 200) {
          return  ServerResponse.success;
        } else {
          debugPrint("remove product from cart: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("remove product from cart: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("remove product from cart: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

  @override
  Future getQuantityItem() async{
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.get(
          '$cartEndpoint/',
          options: Options(headers: headers),
        );
        ResponseObject responseObject = ResponseObject.fromJson(response.data);
        if (response.statusCode == 200) {
          List<CartDetail> datas = List<CartDetail>.from(responseObject.data["listCartDetail"].map((jsonData) => CartDetail.fromJson(jsonData)));
          return datas.length;
        } else {
          debugPrint("get cart: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("get cart: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("get cart: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

}
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

  Future getListUser();

  Future updateUserInfo(String fullName, String birthday, String phoneNumber, String gender);

  Future registerAccount(String username, String password, String fullName, String phoneNumber, String email);

  Future activeUser(String username);

  Future setRoleForUser(String username,String roleName);
}

class UserInfoApi extends UserInfoClient{
  static const userEndpoint = "/user";


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
          '$userEndpoint/info',
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

  @override
  Future getListUser() async{
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.get(
          '$userEndpoint/',
          options: Options(headers: headers),
        );
        ResponseObject responseObject = ResponseObject.fromJson(response.data);
        if (response.statusCode == 200) {
          List<UserModel> datas = List<UserModel>.from(responseObject.data.map((jsonData) => UserModel.fromJson(jsonData)));
          return datas;
        } else {
          debugPrint("get users: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("get users: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("get users: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

  @override
  Future updateUserInfo(String fullName, String birthday, String phoneNumber, String gender) async{
    final requestBody = {
      "fullName": fullName,
      "birthday": birthday,
      "phoneNumber" : phoneNumber,
      "gender": gender,
    };

    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.post(
          '$userEndpoint/update',
          options: Options(headers: headers),
          data: requestBody,
        );
        if (response.statusCode == 200) {
          return  ServerResponse.success;
        } else {
          debugPrint("update user: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("update user: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("update user: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

  @override
  Future registerAccount(String username, String password, String fullName, String phoneNumber, String email) async{
    final requestBody = {
      "username": username,
      "password": password,
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,

    };

    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.post(
          '$userEndpoint/create',
          data: requestBody,
        );
        if (response.statusCode == 200) {
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

  @override
  Future activeUser(String username) async{
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.post(
          '$userEndpoint/active/$username',
          options: Options(headers: headers),
        );
        if (response.statusCode == 200) {
          return  ServerResponse.success;
        } else {
          debugPrint("active user: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("active user: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("active user: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

  @override
  Future setRoleForUser(String username, String roleName) async{
    final requestBody = {
      "username": username,
      "role": roleName,
    };

    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      //Kiểm tra xem có kết nối mạng hay không
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        final response = await dio.post(
          '$userEndpoint/setRole',
          options: Options(headers: headers),
          data: requestBody,
        );
        if (response.statusCode == 200) {
          return  ServerResponse.success;
        } else {
          debugPrint("set role: Server not response!");
          return ServerResponse.noResponse;
        }
      } else {
        debugPrint("set role: No connectivity!");
        return ServerResponse.noConnectivity;
      }
    } on Exception {
      debugPrint("set role: Error found!");
      return ServerResponse.connectionFailed;
    }
  }

}
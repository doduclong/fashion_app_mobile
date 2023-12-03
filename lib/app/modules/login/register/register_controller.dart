import 'package:fashion_app/app/data/services/login_api.dart';
import 'package:fashion_app/app/data/services/user_info_api.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/models/user_model.dart';
import 'package:fashion_app/core/utils/flutx/lib/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{

  late TextEditingController emailTE, passwordTE;
  GlobalKey<FormState> formKey = GlobalKey();
  int emailCounter = 0;
  int passwordCounter = 0;
  final storedToken = "".obs;
  final storedRefreshToken = "".obs;

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Vui lòng điền tài khoản";
    } else if (FxStringUtils.isEmail(text)) {

      return "Tài khoản không hợp lệ";
    }
    return null;
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {

      return "Vui lòng điền mật khẩu";
    } else if (!FxStringUtils.validateStringRange(
      text,
    )) {
      return "Mật khẩu từ 6-20 ký tự";
    }
    return null;
  }

  Future<String> register() async {
    emailCounter = 0;
    passwordCounter = 0;
    if (formKey.currentState!.validate()) {
      await Future.delayed(const Duration(milliseconds: 1000));
    }
    String result = await LoginApi().authenticate(emailTE.text, passwordTE.text);

    if(result == ServerResponse.success){
       //await getUserInfo();
    }
    return result;
  }



  @override
  void onInit() {
    emailTE = TextEditingController(text: '');
    passwordTE = TextEditingController(text: '');
    super.onInit();
  }
}
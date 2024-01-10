
import 'package:fashion_app/app/data/services/user_info_api.dart';
import 'package:fashion_app/core/utils/flutx/lib/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{
  final isLoading = false.obs;

  late TextEditingController usernameTE, passwordTE, rePasswordTE, fullNameTE, emailTE, phoneNumberTE;
  GlobalKey<FormState> registerKey = GlobalKey<FormState>(debugLabel: '_registerKey');
  int emailCounter = 0;
  int passwordCounter = 0;
  final storedToken = "".obs;
  final storedRefreshToken = "".obs;

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Vui lòng điền thông tin";
    } else if (FxStringUtils.isEmail(text)) {
      return "Không hợp lệ";
    }
    return null;
  }

  String? validateText(String? text) {
    if (text == null || text.isEmpty) {
      return "Vui lòng điền thông tin";
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

  String? validateRePassword(String? text) {
    if (text != passwordTE.text) {
      return "Không trùng khớp với mật khẩu";
    }
    return null;
  }

  Future<String> register() async {
    isLoading.value = true;
    emailCounter = 0;
    passwordCounter = 0;
    if (registerKey.currentState!.validate()) {
      await Future.delayed(const Duration(milliseconds: 1000));
    }
    String result = await UserInfoApi().registerAccount(usernameTE.text, passwordTE.text, fullNameTE.text, phoneNumberTE.text, emailTE.text);
    isLoading.value = false;
    return result;
  }



  @override
  void onInit() {
    usernameTE = TextEditingController(text: '');
    passwordTE = TextEditingController(text: '');
    fullNameTE = TextEditingController(text: '');
    phoneNumberTE = TextEditingController(text: '');
    emailTE = TextEditingController(text: '');
    rePasswordTE = TextEditingController(text: '');
    super.onInit();
  }
}
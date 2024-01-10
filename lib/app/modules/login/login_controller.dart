import 'package:fashion_app/app/data/services/login_api.dart';
import 'package:fashion_app/app/data/services/user_info_api.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/models/user_model.dart';
import 'package:fashion_app/core/utils/flutx/lib/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  final storedEmail = "".obs;
  final storedFullName = "".obs;
  final storedUsername = "".obs;
  final storedUserId = "".obs;
  final storedPhoneNumber = "".obs;
  final storedGender = "".obs;
  final storedRole = "".obs;
  final storedBirthday = "".obs;
  final isLoading = false.obs;


  late TextEditingController emailTE, passwordTE;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>(debugLabel: '_loginKey');
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

  Future<String> login() async {
    isLoading.value = true;
    emailCounter = 0;
    passwordCounter = 0;
    if (loginKey.currentState!.validate()) {
      await Future.delayed(const Duration(milliseconds: 1000));
    }
    String result = await LoginApi().authenticate(emailTE.text, passwordTE.text);

    if(result == ServerResponse.success){
        await getUserInfo();
    }
    isLoading.value = false;
    return result;
  }

  Future<void> getUserInfo() async{
    try{
      UserModel user = await UserInfoApi().getUserInfo();
      storedUserId.value = user.id.toString();
      storedUsername.value = user.username ?? "";
      storedBirthday.value = user.birthday ?? "";
      storedPhoneNumber.value = user.phoneNumber ?? "";
      storedGender.value = user.gender ?? "";
      storedEmail.value = user.email ?? "";
      storedFullName.value = user.fullName ?? "";
      storedRole.value = user.role ?? "";

    }catch(e){
      print(e);
    }
  }

  void goToRegisterScreen() {

  }

  @override
  void onInit() {
    emailTE = TextEditingController(text: '');
    passwordTE = TextEditingController(text: '');
    super.onInit();
  }
}
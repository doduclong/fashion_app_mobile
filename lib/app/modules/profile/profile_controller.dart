import 'package:fashion_app/app/data/services/user_info_api.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  final isLoading = false.obs;

  final genderList = [
    "Nam",
    "Nữ",
  ];

  final avatar = "".obs;
  final isUpdating = false.obs;
  final filePathAvatarUpload = "".obs;
  final pathAvatarUpload = "".obs;
  final birthday = "".obs;
  final gender = "".obs;

  final TextEditingController usernameTextControl = TextEditingController();
  final TextEditingController fullNameTextControl = TextEditingController();
  final TextEditingController birthdayTextControl = TextEditingController();
  final TextEditingController emailTextControl = TextEditingController();
  final TextEditingController phoneNumberTextControl = TextEditingController();


  Future updateUserInfo(String fullName, String birthday, String phoneNumber, String gender) async{
    String result = await UserInfoApi().updateUserInfo(fullName, birthday, phoneNumber, gender);
    return result;
  }

  @override
  void onInit() {
    usernameTextControl.text = Get.find<LoginController>().storedUsername.value;
    fullNameTextControl.text = Get.find<LoginController>().storedFullName.value;
    birthdayTextControl.text = Get.find<LoginController>().storedBirthday.value;
    emailTextControl.text = Get.find<LoginController>().storedEmail.value;
    phoneNumberTextControl.text = Get.find<LoginController>().storedPhoneNumber.value;
    if(Get.find<LoginController>().storedGender.value == "MALE" ){
      gender.value = "Nam";
    }else{
      gender.value = "Nữ";
    }
    super.onInit();
  }
}
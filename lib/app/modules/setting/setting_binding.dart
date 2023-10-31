import 'package:fashion_app/app/modules/setting/setting_controller.dart';
import 'package:get/get.dart';

class SettingBinding{
  @override
  void dependencies() {
    Get.put(SettingController());
  }
}
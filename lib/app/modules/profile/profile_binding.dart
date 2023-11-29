import 'package:fashion_app/app/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}
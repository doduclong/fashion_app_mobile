import 'package:fashion_app/app/modules/home/home_controller.dart';
import 'package:fashion_app/app/modules/overlay/overlay_controller.dart';
import 'package:get/get.dart';

class OverlayBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(HomeController());
    Get.put(OverlayController());
  }
}
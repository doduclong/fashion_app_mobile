import 'package:get/get.dart';

class ScreenSizeController extends GetxController {
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  void onInit() {
    super.onInit();
    // Lấy thông tin kích thước màn hình khi ứng dụng khởi tạo
    screenWidth = Get.width;
    screenHeight = Get.height;
  }
}

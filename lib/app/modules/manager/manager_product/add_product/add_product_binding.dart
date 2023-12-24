import 'package:fashion_app/app/modules/manager/manager_product/add_product/add_product_controller.dart';
import 'package:get/get.dart';

class AddProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AddProductController());
  }
}
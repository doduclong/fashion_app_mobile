import 'package:fashion_app/app/modules/product/all_product/all_product_controller.dart';
import 'package:get/get.dart';

class AllProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AllProductController());
  }
}
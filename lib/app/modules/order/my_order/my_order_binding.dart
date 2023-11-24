import 'package:fashion_app/app/modules/order/my_order/my_order_controller.dart';
import 'package:get/get.dart';

class MyOrderBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MyOrderController());
  }
}
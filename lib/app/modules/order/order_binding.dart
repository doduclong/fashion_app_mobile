import 'package:fashion_app/app/modules/order/order_controller.dart';
import 'package:get/get.dart';

class OrderBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(OrderController());
  }
}
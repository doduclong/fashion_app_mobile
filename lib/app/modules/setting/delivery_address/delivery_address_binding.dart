import 'package:fashion_app/app/modules/setting/delivery_address/delivery_address_controller.dart';
import 'package:get/get.dart';

class DeliveryAddressBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(DeliveryAddressController());
  }
}
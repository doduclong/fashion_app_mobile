import 'package:fashion_app/app/modules/manager/manager_category/manager_category_controller.dart';
import 'package:get/get.dart';

class ManagerCategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ManagerCategoryController());
  }
}
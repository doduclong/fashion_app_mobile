import 'package:fashion_app/app/modules/search/search_controller.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SearchProductController());
  }
}
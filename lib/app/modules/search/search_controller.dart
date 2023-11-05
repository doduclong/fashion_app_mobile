import 'package:fashion_app/app/models/product/product.dart';
import 'package:get/get.dart';

class SearchProductController extends GetxController{
  final isLoading = false.obs;
  final listProduct = <Product>[].obs;
}
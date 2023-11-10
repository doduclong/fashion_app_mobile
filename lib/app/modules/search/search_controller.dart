import 'package:fashion_app/app/data/services/product_api.dart';
import 'package:fashion_app/app/models/product/product.dart';
import 'package:get/get.dart';

class SearchProductController extends GetxController{
  final isLoading = false.obs;
  final listProduct = <Product>[].obs;

  void getProducts() async{
    try{
      listProduct.value =await ProductApi().getProducts();
    }catch(e){
      print(e);
    }
  }

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }
}
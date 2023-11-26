

import 'package:fashion_app/app/data/services/cart_api.dart';
import 'package:fashion_app/app/data/services/product_api.dart';
import 'package:fashion_app/app/models/product/product.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  final isLoading = false.obs;
  final listProduct = <Product>[].obs;
  final cartItems = 0.obs;

  void getProducts() async{
    try{
      listProduct.value =await ProductApi().getProducts();
    }catch(e){
      print(e);
    }
  }

  void getQuantityItemCart() async{
    try{
      cartItems.value =await CartApi().getQuantityItem();
    }catch(e){
      print(e);
    }
  }

  @override
  void onInit() {
    getProducts();
    getQuantityItemCart();
    super.onInit();
  }
}
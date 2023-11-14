import 'package:fashion_app/app/data/services/cart_api.dart';
import 'package:fashion_app/app/data/services/product_api.dart';
import 'package:fashion_app/app/models/product/product.dart';
import 'package:fashion_app/app/modules/cart/cart_controller.dart';
import 'package:fashion_app/app/modules/search/search_controller.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  final isLoading = false.obs;
  Rx<Product> selectedProduct = Rx<Product>(Product());
  final quantity = 1.obs;

  void increaseQuantity(){
    quantity.value ++;
  }

  void decreaseQuantity(){
    quantity.value --;
  }

  void getProductById(int id) async{
    isLoading.value = true;
    try{
      selectedProduct.value = await ProductApi().getProductById(id);
    }catch(e){
      print(e);
    }
    isLoading.value = false;
  }

  Future addProductToCart(String nameProduct, int quantity) async{
    isLoading.value = true;
    try{
      String result = await CartApi().addProductToCart(nameProduct, quantity);
      Get.find<CartController>().getListCartDetail();
      isLoading.value = false;
      return result;
    }catch(e){
      print(e);
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getProductById(Get.find<SearchProductController>().selectedProduct.value.id!);
    super.onInit();
  }
}
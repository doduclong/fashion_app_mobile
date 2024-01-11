import 'package:fashion_app/app/data/services/cart_api.dart';
import 'package:fashion_app/app/data/services/product_api.dart';
import 'package:fashion_app/app/models/product/product.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/home/home_controller.dart';
import 'package:fashion_app/app/modules/search/search_controller.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  final isLoading = false.obs;
  Rx<Product> selectedProduct = Rx<Product>(Product());
  final quantity = 1.obs;
  final selectedSize = ''.obs;
  final existQuantity = 0.obs;

  void increaseQuantity(){
    if(quantity < existQuantity.value){
      quantity.value ++;
    }

  }

  void decreaseQuantity(){
    if(quantity>1){
      quantity.value --;
    }
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
      String result = await CartApi().addProductToCart(nameProduct, quantity, selectedSize.value);
      //Get.find<CartController>().getListCartDetail();
      Get.find<HomeController>().getQuantityItemCart();
      isLoading.value = false;
      return result;
    }catch(e){
      print(e);
      isLoading.value = false;
      return ServerResponse.noResponse;
    }
  }

  @override
  void onInit() {
    getProductById(Get.find<SearchProductController>().selectedProduct.value.id!);
    existQuantity.value = Get.find<SearchProductController>().selectedProduct.value.sizes![0].quantity ?? 0;
    selectedSize.value = Get.find<SearchProductController>().selectedProduct.value.sizes![0].size ?? "";
    super.onInit();
  }
}
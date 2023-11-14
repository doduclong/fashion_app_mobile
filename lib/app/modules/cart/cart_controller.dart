import 'package:fashion_app/app/data/services/cart_api.dart';
import 'package:fashion_app/app/models/cart/cart_detail.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  final isLoading = false.obs;
  final listCartDetail = <CartDetail>[].obs;

  void increment(CartDetail cart) {
    cart.quantity ++;
    updateQuantity(cart.id!, cart.quantity);
  }

  void decrement(CartDetail cart) {
    cart.quantity --;
    updateQuantity(cart.id!, cart.quantity);
  }

  void updateQuantity(int cartDetailId, int quantity) async{
    await CartApi().updateQuantity(cartDetailId, quantity);
    getListCartDetail();
  }

  int total(){
    int totalMoney = 0;
    for(int cartIndex=0; cartIndex <listCartDetail.length; cartIndex++){
      totalMoney += ((listCartDetail[cartIndex].product!.price ?? 1) * listCartDetail[cartIndex].quantity);
    }
    return totalMoney;
  }

  void getListCartDetail() async{
    try{
      listCartDetail.value =await CartApi().getCartDetail();
    }catch(e){
      print(e);
    }
  }
  @override
  void onReady() {
    getListCartDetail();
    super.onReady();
  }

  @override
  void onInit() {
    getListCartDetail();
    super.onInit();
  }
}
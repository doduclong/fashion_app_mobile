import 'package:fashion_app/app/data/services/cart_api.dart';
import 'package:fashion_app/app/models/cart/cart_detail.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  final isLoading = false.obs;
  final listCartDetail = <CartDetail>[].obs;

  void increment(CartDetail cart) {
    cart.quantity ++;
    update();
  }

  void decrement(CartDetail cart) {
    cart.quantity --;
    update();
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
    // listCartDetail.add(
    //     CartDetail(
    //         product: Product(
    //             id: 1,
    //             name: "Áo polo",
    //             describe: './assets/images/apps/shopping/product/product-5.jpg',
    //             category: null,
    //             price: 300000,
    //         ),
    //         quantity: 3)
    // );
    super.onInit();
  }
}
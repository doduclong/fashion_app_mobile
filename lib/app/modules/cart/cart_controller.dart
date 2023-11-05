import 'package:fashion_app/app/models/cart/cart_detail.dart';
import 'package:fashion_app/app/models/product/product.dart';
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

  @override
  void onInit() {
    listCartDetail.add(
        CartDetail(
            product: Product(
                id: 1,
                name: "Áo polo",
                description: './assets/images/apps/shopping/product/product-5.jpg',
                branch: "HM",
                category: null,
                price: 300000,
                quantity: 3
            ),
            quantity: 3)
    );
    super.onInit();
  }
}
import 'package:fashion_app/app/data/services/order_api.dart';
import 'package:fashion_app/app/models/order/order.dart';
import 'package:get/get.dart';

class MyOrderController extends GetxController{
  final isLoading = false.obs;
  final myOrders = <Order>[].obs;

  Future getMyOrder() async{
    try{
      myOrders.value = await OrderApi().getOrdersOfUser();
    }catch(e){
      print(e);
    }
  }

  @override
  void onInit() async{
    isLoading.value = true;
    await getMyOrder();
    isLoading.value = false;
    super.onInit();
  }
}
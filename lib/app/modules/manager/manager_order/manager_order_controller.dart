import 'package:fashion_app/app/data/services/order_api.dart';
import 'package:fashion_app/app/models/order/order.dart';
import 'package:get/get.dart';

class ManagerOrderController extends GetxController{
  final isLoading = false.obs;
  final myOrders = <Order>[].obs;
  final status = "".obs;

  final statusList = [
    "NEW",
    "HOLD",
    "SHIPPING",
    "DELIVERY",
    "CANCELLED"
  ];

  Future getMyOrder() async{
    try{
      myOrders.value = await OrderApi().getOrdersOfUser();
    }catch(e){
      print(e);
    }
  }

  Future setStatusOrder(String status) async{
    // String result = await UserInfoApi().setRoleForUser(username, roleName);
    // getListUser();
    // return result;
  }

  @override
  void onInit() async{
    isLoading.value = true;
    await getMyOrder();
    isLoading.value = false;
    super.onInit();
  }
}
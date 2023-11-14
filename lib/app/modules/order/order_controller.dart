import 'package:fashion_app/app/data/services/delivery_address_api.dart';
import 'package:fashion_app/app/models/delivery_address_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  final isLoading = false.obs;
  final listDeliveryAddress = <DeliveryAddressModel>[].obs;


  Future getDeliveryAddress() async{
    try{
      listDeliveryAddress.value = await DeliveryAddressApi().getDeliveryAddresses();
    }catch(e){
      print(e);
    }
  }

  @override
  void onInit() async{
    isLoading.value = true;
    await getDeliveryAddress();
    isLoading.value = false;
    super.onInit();
  }
}
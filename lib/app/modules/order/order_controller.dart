import 'package:fashion_app/app/data/services/delivery_address_api.dart';
import 'package:fashion_app/app/data/services/order_api.dart';
import 'package:fashion_app/app/models/delivery_address_model.dart';
import 'package:fashion_app/app/models/request/order_detail_request.dart';
import 'package:fashion_app/app/modules/cart/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  final isLoading = false.obs;
  final listDeliveryAddress = <DeliveryAddressModel>[].obs;
  final selectedAddressId = 0.obs;
  Rx<DeliveryAddressModel> selectedAddress = Rx<DeliveryAddressModel>(DeliveryAddressModel());
  TextEditingController noteControl = TextEditingController();
  final listSelectedItem = <OrderDetailRequest>[].obs;
  final listSelectedCartDetailId = <int>[].obs;
  final payment = "Tiền mặt".obs;


  Future getDeliveryAddress() async{
    try{
      listDeliveryAddress.value = await DeliveryAddressApi().getDeliveryAddresses();
    }catch(e){
      print(e);
    }
  }

  Future order(List<OrderDetailRequest> orderDetails) async{
    try{
      String result = await OrderApi().order(orderDetails, payment.value, noteControl.text, selectedAddress.value.fullName ?? "", selectedAddress.value.address ?? "", selectedAddress.value.phoneNumber ?? "", listSelectedCartDetailId);
      return result;
    }catch(e){
      print(e);
    }
  }

  Future getDataFromCart() async{
    for(int i=0; i< Get.find<CartController>().selectedCartDetails.length; i++){
      listSelectedItem.add(OrderDetailRequest(name: Get.find<CartController>().selectedCartDetails[i].product!.name!, quantity: Get.find<CartController>().selectedCartDetails[i].quantity, size: Get.find<CartController>().selectedCartDetails[i].size));
      listSelectedCartDetailId.add(Get.find<CartController>().selectedCartDetails[i].id!);
    }
  }

  @override
  void onInit() async{
    isLoading.value = true;
    await getDeliveryAddress();
    if(listDeliveryAddress.isNotEmpty){
      selectedAddress.value = listDeliveryAddress[0];
    }
    await getDataFromCart();
    isLoading.value = false;
    super.onInit();
  }
}
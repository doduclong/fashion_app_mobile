import 'package:fashion_app/app/data/services/delivery_address_api.dart';
import 'package:fashion_app/app/models/delivery_address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryAddressController extends GetxController{
  final isLoading = false.obs;
  final listDeliveryAddress = <DeliveryAddressModel>[].obs;
  TextEditingController fullNameControl = TextEditingController();
  TextEditingController phoneNumberControl = TextEditingController();
  TextEditingController addressControl = TextEditingController();

  void getDeliveryAddress() async{
    try{
      listDeliveryAddress.value = await DeliveryAddressApi().getDeliveryAddresses();
    }catch(e){
      print(e);
    }
  }

  Future createDeliveryAddress(String address, String fullName, String phoneNumber) async{
    try{
      String result = await DeliveryAddressApi().createDeliveryAddress(address, fullName, phoneNumber);
      getDeliveryAddress();
      return result;
    }catch(e){
      print(e);
    }
  }


  @override
  void onInit() {
    isLoading.value = true;
    getDeliveryAddress();
    isLoading.value = false;
    super.onInit();
  }
}
import 'package:fashion_app/app/data/services/delivery_address_api.dart';
import 'package:fashion_app/app/models/delivery_address_model.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryAddressController extends GetxController{
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
      return result;
    }catch(e){
      print(e);
    }
  }


  @override
  void onInit() {
    //getDeliveryAddress();
    listDeliveryAddress.addAll([DeliveryAddressModel(id: 1, phoneNumber: "0123456789", address: "Hà Nội", fullName: "Đỗ Long"),DeliveryAddressModel(id: 1, phoneNumber: "0123456789", address: "Hà Nội", fullName: "Đỗ Đức Long") ]);
    super.onInit();
  }
}
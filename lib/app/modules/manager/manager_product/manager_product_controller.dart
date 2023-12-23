import 'package:fashion_app/app/data/services/product_api.dart';
import 'package:fashion_app/app/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagerProductController extends GetxController{
  final isLoading = false.obs;
  final listProduct = <Product>[].obs;
  TextEditingController searchTextControl = TextEditingController();
  Rx<Product> selectedProduct = Rx<Product>(Product());

  void getProducts() async{
    try{
      listProduct.value =await ProductApi().getProducts();
    }catch(e){
      print(e);
    }
  }

  void searchProduct(String searchText) async{
    try{
      listProduct.value =await ProductApi().searchProduct(searchText);
    }catch(e){
      print(e);
    }
  }

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }
}
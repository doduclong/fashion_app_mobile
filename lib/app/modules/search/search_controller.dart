import 'dart:convert';
import 'dart:io';

import 'package:fashion_app/app/data/services/product_api.dart';
import 'package:fashion_app/app/data/services/search_image_api.dart';
import 'package:fashion_app/app/models/product/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchProductController extends GetxController{
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

  Future<String> searchByImage(File file) async{
    isLoading.value = true;
    final bytes = file.readAsBytesSync();
    String img64 = base64Encode(bytes);
    String result = await SearchImageApi().searchImage("data:image/jpeg;base64,$img64") ?? "";
    searchProduct(result);
    print(result);
    isLoading.value = false;
    return result;
  }

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }
}
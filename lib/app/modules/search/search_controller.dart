import 'dart:convert';
import 'dart:io';

import 'package:fashion_app/app/data/services/category_api.dart';
import 'package:fashion_app/app/data/services/product_api.dart';
import 'package:fashion_app/app/data/services/search_image_api.dart';
import 'package:fashion_app/app/models/category.dart';
import 'package:fashion_app/app/models/product/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchProductController extends GetxController{
  final isLoading = false.obs;
  final listProduct = <Product>[].obs;
  final listCategory = <Category>[].obs;
  TextEditingController searchTextControl = TextEditingController();
  Rx<Product> selectedProduct = Rx<Product>(Product());

  void getCategories() async{
    try{
      listCategory.value =await CategoryApi().getCategories();
    }catch(e){
      print(e);
    }
  }

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

  void searchProductByKeywords(List<String> keywords) async{
    try{
      listProduct.value =await ProductApi().searchProductByKeywords(keywords);
    }catch(e){
      print(e);
    }
  }

  Future searchProductByCategory(String categoryId) async{
    isLoading.value = true;
    try{
      listProduct.value =await ProductApi().searchProductByCategory(categoryId);
    }catch(e){
      print(e);
    }
    isLoading.value = false;
  }

  Future<String> searchByImage(File file) async{
    isLoading.value = true;
    final bytes = file.readAsBytesSync();
    String img64 = base64Encode(bytes);
    List<String> result = await SearchImageApi().searchImage("data:image/jpeg;base64,$img64") ?? "";
    //searchProduct(result);
    searchProductByKeywords(result);
    print(result);
    isLoading.value = false;
    return "";
  }

  @override
  void onInit() {
    getCategories();
    getProducts();
    super.onInit();
  }
}
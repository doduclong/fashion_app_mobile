import 'dart:io';

import 'package:fashion_app/app/data/services/category_api.dart';
import 'package:fashion_app/app/data/services/product_api.dart';
import 'package:fashion_app/app/models/category.dart';
import 'package:fashion_app/app/models/product/size_product.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController{
  final isLoading = false.obs;
  late TextEditingController nameTE, describeTE, priceTE;
  TextEditingController categoryTextControl = TextEditingController();
  TextEditingController sizeControl = TextEditingController();
  TextEditingController quantityControl = TextEditingController();
  late File file;
  final sizes = <SizeProduct>[].obs;
  final listCategory = <Category>[].obs;
  Rx<Category> selectedCategory = Rx<Category>(Category());
  final fileUrl = "".obs;

  Future<String> add(File file, String name, String price, String describe, int categoryId, String classification, String sizes) async {
    print(sizes.replaceAll('\'', ""));
    String sizeReplace = sizes.replaceAll('\'', "");
    String result = await ProductApi().createProduct(file, name, price, describe, categoryId,classification, sizeReplace);

    if(result == ServerResponse.success){
      //await getUserInfo();
    }
    return result;
  }

  Future getCategories() async{
    try{
      listCategory.value = await CategoryApi().getCategories();
    }catch(e){
      print(e);
    }
  }

  void addSize(String name, int quantity){
    sizes.add(SizeProduct(size: name, quantity: quantity));
  }

  @override
  void onInit() async{
    isLoading.value = true;

    nameTE = TextEditingController(text: '');
    describeTE = TextEditingController(text: '');
    priceTE = TextEditingController(text: '');
    await getCategories();
    isLoading.value = false;
    super.onInit();
  }
}
import 'package:fashion_app/app/data/services/category_api.dart';
import 'package:fashion_app/app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagerCategoryController extends GetxController{
  final isLoading = false.obs;
  final listCategory = <Category>[].obs;
  TextEditingController categoryControl = TextEditingController();

  Future getCategories() async{
    try{
      listCategory.value = await CategoryApi().getCategories();
    }catch(e){
      print(e);
    }
  }

  Future addCategory(String name) async{
    String result = await CategoryApi().createCategory(name);
    await getCategories();
    return result;
  }

  Future updateCategory(int id, String name) async{
    String result = await CategoryApi().updateCategory(id, name);
    await getCategories();
    return result;
  }

  @override
  void onInit() async{
    isLoading.value = true;
    await getCategories();
    isLoading.value = false;
    super.onInit();
  }
}
import 'package:fashion_app/app/data/services/user_info_api.dart';
import 'package:fashion_app/app/models/user_model.dart';
import 'package:get/get.dart';

class ManagerUserController extends GetxController{
  final listUser = <UserModel>[].obs;

  void getListUser() async{
    try{
      listUser.value = await UserInfoApi().getListUser();
    }catch(e){
      print(e);
    }
  }

  @override
  void onInit() {
    getListUser();
    super.onInit();
  }
}
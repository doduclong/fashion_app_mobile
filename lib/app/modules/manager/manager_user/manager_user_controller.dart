import 'package:fashion_app/app/data/services/user_info_api.dart';
import 'package:fashion_app/app/models/user_model.dart';
import 'package:get/get.dart';

class ManagerUserController extends GetxController{
  final isLoading = false.obs;
  final listUser = <UserModel>[].obs;

  void getListUser() async{
    try{
      listUser.value = await UserInfoApi().getListUser();
    }catch(e){
      print(e);
    }
  }

  Future setRoleForUser(String username, String roleName) async{
    String result = await UserInfoApi().setRoleForUser(username, roleName);
    return result;
  }

  Future activeUser(String username, String roleName) async{
    String result = await UserInfoApi().activeUser(username);
    return result;
  }

  @override
  void onInit() {
    getListUser();
    super.onInit();
  }
}
import 'package:fashion_app/app/data/services/user_info_api.dart';
import 'package:fashion_app/app/models/user_model.dart';
import 'package:get/get.dart';

class ManagerUserController extends GetxController{
  final isLoading = false.obs;
  final listUser = <UserModel>[].obs;
  final role = "".obs;

  final roleList = [
    "USER",
    "ADMIN",
    "MANAGER"
  ];

  void getListUser() async{
    try{
      listUser.value = await UserInfoApi().getListUser();
    }catch(e){
      print(e);
    }
  }

  Future setRoleForUser(String username, String roleName) async{
    String result = await UserInfoApi().setRoleForUser(username, roleName);
    getListUser();
    return result;
  }

  Future activeUser(String username) async{
    String result = await UserInfoApi().activeUser(username);
    getListUser();
    return result;
  }

  @override
  void onInit() {
    getListUser();
    super.onInit();
  }
}
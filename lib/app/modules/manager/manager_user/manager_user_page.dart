import 'package:fashion_app/app/models/user_model.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/app/modules/manager/manager_user/manager_user_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ManagerUserPage extends GetView<ManagerUserController> {

  ManagerUserPage({super.key});

  ThemeData theme = AppTheme.theme;
  CustomTheme customTheme = AppTheme.customTheme;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 2,
            shadowColor: Colors.white54,
            centerTitle: true,
            backgroundColor: const Color(0xffffffff),
            title: FxText.titleMedium(
              "Quản lý người dùng",
              color: theme.primaryColor,
            ),
          ),
          body: Obx(()=> Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controller.listUser.length,
              itemBuilder: (BuildContext context, int index) {
                UserModel user = controller.listUser[index];
                return userWidget(
                    user, (){}
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(height: 0);
              },
            ),
          )
          ),
        ));
  }

  Widget userWidget(UserModel user, Function() onTap) {
    return FxContainer(
      paddingAll: 0,
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
              child: FxText.bodyMedium(
                user.username ?? "",
                color: theme.colorScheme.onBackground,
                fontWeight: 600,
              )),

          Expanded(
              child: FxText.bodyMedium(
                user.fullName ?? "",
                color: theme.colorScheme.onBackground,
                fontWeight: 600,
              )),
        ],
      ),
    );
  }
}
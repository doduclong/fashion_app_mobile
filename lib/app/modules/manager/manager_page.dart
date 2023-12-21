
import 'package:fashion_app/app/modules/manager/manager_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';


class ManagerPage extends GetView<ManagerController> {

  ManagerPage({super.key});

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
              "Quản lý",
              color: theme.primaryColor,
            ),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: theme.primaryColor,
                )),
          ),
          body: ListView(
            padding: FxSpacing.fromLTRB(
                20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
            children: [
              _buildSingleRow('Quản lý tài khoản', Icons.perm_identity, (){
                Get.toNamed(AppRoutes.managerUser);
              }),
              FxSpacing.height(20),
              _buildSingleRow('Quản lý danh mục', Icons.category_outlined, (){
                Get.toNamed(AppRoutes.managerCategory);
              }),
              FxSpacing.height(20),
              _buildSingleRow('Quản lý sản phẩm', Icons.h_mobiledata_sharp, (){
                Get.toNamed(AppRoutes.managerProduct);
              }),
              FxSpacing.height(20),
              _buildSingleRow('Quản lý đơn hàng', Icons.shopping_cart_outlined, (){
                Get.toNamed(AppRoutes.managerOrder);
              }),
              FxSpacing.height(20),
            ],
          ),
        ));
  }

  Widget _buildSingleRow(String name, IconData icon, Function() onTap) {
    return FxContainer(
      paddingAll: 0,
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
          ),
          FxSpacing.width(20),
          Expanded(
              child: FxText.bodyMedium(
                name,
                color: theme.colorScheme.onBackground,
                fontWeight: 600,
              )),
          FxSpacing.width(20),
          const Icon(
            FeatherIcons.chevronRight,
            size: 20,
          ),
        ],
      ),
    );
  }
}
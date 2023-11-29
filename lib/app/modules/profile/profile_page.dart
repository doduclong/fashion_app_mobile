import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/app/modules/profile/profile_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfilePage extends GetView<ProfileController> {

  ProfilePage({super.key});

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
              "THÔNG TIN CÁ NHÂN",
              color: theme.primaryColor,
            ),
          ),
          body: ListView(
            padding: FxSpacing.fromLTRB(
                20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
            children: [
              Column(
                children: <Widget>[
                  const FxContainer.rounded(
                    paddingAll: 0,
                    width: 80,
                    height: 80,
                    child: Image(
                        image: AssetImage("./assets/images/profile/avatar_3.jpg"),
                        fit: BoxFit.fill),
                  ),
                  FxSpacing.height(8),
                  FxText.titleMedium(Get.find<LoginController>().storedFullName.value, color: theme.colorScheme.onBackground,
                      fontWeight: 600, letterSpacing: 0),
                ],
              ),
              FxSpacing.height(20),
              _buildSingleRow('Thiết lập tài khoản', Icons.manage_accounts, (){}),
              FxSpacing.height(20),
              _buildSingleRow('Đơn hàng của tôi', Icons.content_paste, (){
                Get.toNamed(AppRoutes.myOrder);
              }),
              FxSpacing.height(20),
              _buildSingleRow('Địa chỉ giao hàng', Icons.location_on_outlined, (){
                Get.toNamed(AppRoutes.deliveryAddress);
              }),
              FxSpacing.height(20),
              _buildSingleRow('Thông tin ứng dụng', FeatherIcons.eye, (){}),

              Visibility(
                  visible: Get.find<LoginController>().storedRole.value != "USER",
                  child: Column(
                    children: [
                      FxSpacing.height(20),
                      _buildSingleRow('Quản lý', Icons.settings_applications, (){
                        Get.toNamed(AppRoutes.manager);
                      }),
                    ],
                  )),


              FxSpacing.height(20),

              Center(
                child: FxButton(
                  elevation: 0,
                  backgroundColor: theme.colorScheme.primary,
                  borderRadiusAll: 4,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        MdiIcons.logoutVariant,
                        color: theme.colorScheme.onPrimary,
                        size: 18,
                      ),
                      FxSpacing.width(16),
                      FxText.bodySmall("Đăng xuất",
                          letterSpacing: 0.3,
                          fontWeight: 600,
                          color: theme.colorScheme.onPrimary)
                    ],
                  ),
                  onPressed: () {
                  },
                ),
              ),
              // FxContainer(
              //   onTap: () {
              //     //controller.logout();
              //   },
              //   padding: FxSpacing.xy(20, 8),
              //   borderRadiusAll: 4,
              //   color: theme.colorScheme.primary,
              //   child: Center(
              //     child: FxText.bodySmall(
              //       'Đăng xuất',
              //       fontWeight: 700,
              //       letterSpacing: 0.3,
              //       color: theme.colorScheme.onPrimary,
              //     ),
              //   ),
              // ),
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
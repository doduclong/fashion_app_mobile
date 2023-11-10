import 'package:fashion_app/app/common/stateless/custom_dialog/error_dialog.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key}) : super(key: key);

  ThemeData theme = AppTheme.theme;
  CustomTheme customTheme = AppTheme.customTheme;

  OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding:
            FxSpacing.fromLTRB(20, FxSpacing.safeAreaTop(context) + 64, 20, 20),
        children: [
          FxText.displaySmall(
            'Xin chào!',
            textAlign: TextAlign.center,
            color: theme.colorScheme.onBackground,
          ),
          FxSpacing.height(50),
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                TextFormField(
                  style: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      isDense: true,
                      fillColor: theme.cardTheme.color,
                      prefixIcon: Icon(
                        FeatherIcons.mail,
                        color: theme.colorScheme.onBackground,
                      ),
                      hintText: "Tài khoản",
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),
                      hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: controller.emailTE,
                  validator: controller.validateEmail,
                  cursorColor: theme.colorScheme.onBackground,
                ),
                FxSpacing.height(20),
                TextFormField(
                  style: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      isDense: true,
                      fillColor: theme.cardTheme.color,
                      prefixIcon: Icon(
                        FeatherIcons.lock,
                        color: theme.colorScheme.onBackground,
                      ),
                      hintText: "Mật khẩu",
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),
                      hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: controller.passwordTE,
                  validator: controller.validatePassword,
                  cursorColor: theme.colorScheme.onBackground,
                  obscureText: true,
                ),
              ],
            ),
          ),
          FxSpacing.height(20),
          Align(
            alignment: Alignment.centerRight,
            child: FxButton.text(
              onPressed: () {
                //controller.goToForgotPasswordScreen();
              },
              padding: FxSpacing.zero,
              splashColor: theme.colorScheme.primary.withAlpha(40),
              child: Text(
                "Quên mật khẩu ?",
                style: FxTextStyle.bodySmall(color: theme.colorScheme.primary),
              ),
            ),
          ),
          FxSpacing.height(20),
          FxButton.block(
            elevation: 0,
            borderRadiusAll: 4,
            onPressed: () async{
              //Get.toNamed(AppRoutes.home);

              String result = await controller.login();

              if(result == ServerResponse.success){
                Get.toNamed(AppRoutes.home);
              }else{
                if(context.mounted){
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const ErrorDialog(
                            icon: Icons.login,
                            message: "Sai thông tin đăng nhập!");
                      });
                }
              }
            },
            splashColor: theme.colorScheme.onPrimary.withAlpha(28),
            backgroundColor: theme.colorScheme.primary,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FxText.labelLarge(
                    "Đăng nhập",
                    fontWeight: 600,
                    color: theme.colorScheme.onPrimary,
                    letterSpacing: 0.4,
                  ),
                  FxSpacing.width(8),
                  Icon(
                    FeatherIcons.arrowRight,
                    color: theme.colorScheme.onPrimary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          FxSpacing.height(20),
          Divider(),
          FxSpacing.height(20),
          Center(
            child: FxButton.text(
                padding: FxSpacing.zero,
                onPressed: () {
                  controller.goToRegisterScreen();
                },
                child: FxText.labelLarge("Tạo tài khoản",
                    decoration: TextDecoration.underline,
                    color: theme.colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}

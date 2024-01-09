import 'package:fashion_app/app/common/stateless/custom_dialog/error_dialog.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/login/register/register_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  RegisterPage({Key? key}) : super(key: key);

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
    return Obx(()=>controller.isLoading.value
        ? Container(
      color: Colors.white,
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
        child: SpinKitThreeInOut(
          size: 50.0,
          itemBuilder: (_, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color:
                index.isEven ? Colors.white : theme.primaryColor,
              ),
            );
          },
        ),
      ),
    ) : Scaffold(
      body: ListView(
        padding:
            FxSpacing.fromLTRB(20, FxSpacing.safeAreaTop(context) + 10, 20, 20),
        children: [
          FxText.displaySmall(
            'Đăng ký',
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
                        FeatherIcons.edit,
                        color: theme.colorScheme.onBackground,
                      ),
                      hintText: "Họ và tên",
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),
                      hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: controller.fullNameTE,
                  validator: controller.validateText,
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
                        FeatherIcons.phone,
                        color: theme.colorScheme.onBackground,
                      ),
                      hintText: "Số điện thoại",
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),

                      hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                      isCollapsed: true),
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  controller: controller.phoneNumberTE,
                  validator: controller.validateText,
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
                        FeatherIcons.mail,
                        color: theme.colorScheme.onBackground,
                      ),
                      hintText: "Email",
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
                        Icons.perm_identity,
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
                  controller: controller.usernameTE,
                  validator: controller.validateText,
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
                      hintText: "Nhập lại mật khẩu",
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),
                      hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: controller.rePasswordTE,
                  validator: controller.validateRePassword,
                  cursorColor: theme.colorScheme.onBackground,
                  obscureText: true,
                ),
              ],
            ),
          ),
          FxSpacing.height(20),
          FxButton.block(
            elevation: 0,
            borderRadiusAll: 4,
            onPressed: () async{
              //Get.toNamed(AppRoutes.home);

              String result = await controller.register();

              if(result == ServerResponse.success){
                Get.offAndToNamed(AppRoutes.signIn);
              }else{
                if(context.mounted){
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const ErrorDialog(
                            icon: Icons.login,
                            message: "Đăng ký không thành công!");
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
                    "Đăng ký",
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
        ],
      ),
    ));
  }
}

import 'package:fashion_app/app/common/stateless/custom_dialog/confirm_dialog.dart';
import 'package:fashion_app/app/common/stateless/custom_dialog/error_dialog.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/models/user_model.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/app/modules/manager/manager_user/manager_user_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../common/stateless/custom_dialog/success_dialog.dart';

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
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: theme.primaryColor,
                )),
          ),
          body:           Obx(()=>controller.isLoading.value
              ? Container(
            color: Colors.white,
            width: double.maxFinite,
            height: double.maxFinite,
            child: Center(
              child: SpinKitThreeInOut(
                size: 50.0,
                itemBuilder: (_, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: index.isEven
                          ? theme.scaffoldBackgroundColor
                          : theme.primaryColor,
                    ),
                  );
                },
              ),
            ),
          )

              : Container(
            color: theme.scaffoldBackgroundColor,
            child: Column(
              //padding: FxSpacing.zero,
              children: <Widget>[
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: theme.colorScheme.onPrimary,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      padding: FxSpacing.all(10),
                      child:
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.listUser.length,
                        itemBuilder: (BuildContext context, int index) {
                          UserModel user = controller.listUser[index];
                          return userWidget(
                              user,
                              context
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(height: 0);
                        },
                      )
                  ),
                ),
              ],
            ),
          ))
        ));
  }

  Widget userWidget(UserModel user, BuildContext context) {
    return GestureDetector(
      onLongPress: (){
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  backgroundColor: CustomTheme.gray,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  contentPadding: const EdgeInsets.all(10),
                  alignment: Alignment.bottomRight,
                  insetPadding: const EdgeInsets.all(10),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: !user.active!,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return ConfirmDialog(
                                      title: "Xác nhận",
                                      message:
                                      "Bạn muốn kích hoạt tài khoản ${user.username}?",
                                      btnOkOnPress: () async{
                                        String result = await controller.activeUser(user.username!);
                                        if(result == ServerResponse.success){
                                          if (context.mounted) {
                                            await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const SuccessDialog(
                                                      icon: Icons.check,
                                                      message:
                                                      "Kích hoạt thành công!");
                                                });
                                            Get.back();
                                            Get.back();
                                          }
                                        }else{
                                          if (context.mounted) {
                                            await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const ErrorDialog(
                                                      icon: Icons.close,
                                                      message:
                                                      "Đã xảy ra lỗi!");
                                                });
                                          }
                                        }
                                      });
                                });
                          },
                          child: Container(
                            padding:  const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FxText.titleMedium(
                                  "Kích hoạt",
                                  color: theme.primaryColor,
                                ),

                                Icon(Icons.copy, color: theme.primaryColor,)
                              ],
                            ),
                          ),
                        ),
                      ),

                      Visibility(
                        visible: Get.find<LoginController>().storedRole.value == "MANAGER",
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      backgroundColor: CustomTheme.gray,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                      contentPadding: const EdgeInsets.all(30),
                                      alignment: Alignment.center,
                                      insetPadding: const EdgeInsets.all(10),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Obx(
                                                () => DropdownButtonHideUnderline(
                                              child: DropdownButtonFormField(
                                                decoration: const InputDecoration(
                                                  prefixIcon: Icon(FontAwesomeIcons
                                                      .criticalRole),
                                                  labelText: "Chọn quyền",
                                                  border: OutlineInputBorder(
                                                    //borderSide: BorderSide(color: Color(0xFFD0D0D0)),
                                                    borderSide: BorderSide(
                                                        color: Colors.green),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    //<-- SEE HERE
                                                    borderSide: BorderSide(
                                                        color: Color(0xFFD0D0D0)),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    //<-- SEE HERE
                                                    borderSide: BorderSide(
                                                        color: Color(0xFFD0D0D0)),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(10)),
                                                  ),
                                                ),
                                                isExpanded: true,
                                                value:
                                                controller.role.value.isEmpty
                                                    ? null
                                                    : controller.role.value,
                                                isDense: true,
                                                items: controller.roleList
                                                    .map((value) {
                                                  return DropdownMenuItem(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  controller.role.value =
                                                  newValue!;
                                                },
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 14),

                                          FxButton.block(
                                            elevation: 0,
                                            borderRadiusAll: 4,
                                            onPressed: () async{
                                              //Get.toNamed(AppRoutes.home);

                                              String result = await controller.setRoleForUser(user.username!, controller.role.value);

                                              if(result == ServerResponse.success){
                                                if(context.mounted){
                                                  await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return const SuccessDialog(
                                                            icon: Icons.login,
                                                            message: "Thiết lập quyền thành công!");
                                                      });
                                                }
                                                Get.back();
                                                Get.back();
                                              }else{
                                                if(context.mounted){
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return const ErrorDialog(
                                                            icon: Icons.login,
                                                            message: "Thiết lập quyền không thành công!");
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
                                                    "Xác nhận",
                                                    fontWeight: 600,
                                                    color: theme.colorScheme.onPrimary,
                                                    letterSpacing: 0.4,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                        ],
                                      ) );

                                });
                          },
                          child: Container(
                            padding:  const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FxText.titleMedium(
                                  "Thiết lập quyền",
                                  color: theme.primaryColor,
                                ),

                                Icon(Icons.copy, color: theme.primaryColor,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ) );

        });
      },
      child: FxContainer.bordered(
        color: Colors.transparent,
        paddingAll: 4,
        borderRadiusAll: 4,
        margin: FxSpacing.bottom(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: FxContainer.none(
                height: 110,
                color: Colors.transparent,
                margin: FxSpacing.left(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxText.titleMedium(
                            user.username ?? "",
                            fontWeight: 600,
                            color: theme.colorScheme.onBackground
                        ),
                        FxText.titleMedium(
                            user.role ?? "",
                            fontWeight: 600,
                            color: theme.colorScheme.onBackground
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxText.titleMedium(
                            user.fullName ?? "",
                            fontWeight: 600,
                            color: theme.colorScheme.onBackground
                        ),
                        FxText.titleMedium(
                            user.gender ?? "",
                            fontWeight: 600,
                            color: theme.colorScheme.onBackground
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxText.titleMedium(
                            user.birthday ?? "",
                            fontWeight: 600,
                            color: theme.colorScheme.onBackground
                        ),

                        FxText.titleMedium(
                            user.active.toString(),
                            fontWeight: 600,
                            color: user.active! ? customTheme.colorSuccess : customTheme.colorError
                        ),
                      ],
                    ),

                    FxText.titleMedium(
                        user.email ?? "",
                        fontWeight: 600,
                        color: theme.colorScheme.onBackground
                    ),

                    FxText.titleMedium(
                        user.phoneNumber ?? "",
                        fontWeight: 600,
                        color: theme.colorScheme.onBackground
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
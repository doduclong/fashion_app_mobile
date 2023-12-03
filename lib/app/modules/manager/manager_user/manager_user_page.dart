import 'package:fashion_app/app/models/user_model.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/app/modules/manager/manager_user/manager_user_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
                            // await Clipboard.setData(ClipboardData(
                            //     text: widget.content ?? ""));
                            // Get.back();
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

                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
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
                                        Obx(
                                              () => DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField(
                                              decoration: const InputDecoration(
                                                prefixIcon: Icon(FontAwesomeIcons
                                                    .marsAndVenus),
                                                labelText: "Giới tính",
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
                                              controller.gender.value.isEmpty
                                                  ? null
                                                  : controller.gender.value,
                                              isDense: true,
                                              items: controller.genderList
                                                  .map((value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                controller.gender.value =
                                                newValue!;
                                              },
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 14),

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
                            color: theme.colorScheme.onBackground
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
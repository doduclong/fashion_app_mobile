import 'package:fashion_app/app/common/stateless/custom_dialog/confirm_dialog.dart';
import 'package:fashion_app/app/common/stateless/custom_dialog/error_dialog.dart';
import 'package:fashion_app/app/common/stateless/custom_dialog/success_dialog.dart';
import 'package:fashion_app/app/models/category.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/manager/manager_category/manager_category_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ManagerCategoryPage extends GetView<ManagerCategoryController> {

  ManagerCategoryPage({super.key});

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
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 2,
              shadowColor: Colors.white54,
              centerTitle: true,
              backgroundColor: const Color(0xffffffff),
              title: FxText.titleMedium(
                "QUẢN LÝ DANH MỤC",
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

              actions: [
                IconButton(
                    onPressed: () {
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

                                    TextFormField(
                                      style: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                                      decoration: InputDecoration(
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                          filled: true,
                                          isDense: true,
                                          fillColor: theme.cardTheme.color,
                                          prefixIcon: Icon(
                                            Icons.note_alt_outlined,
                                            color: theme.colorScheme.onBackground,
                                          ),
                                          hintText: "Tên danh mục",
                                          enabledBorder: outlineInputBorder,
                                          focusedBorder: outlineInputBorder,
                                          border: outlineInputBorder,
                                          contentPadding: FxSpacing.all(16),
                                          hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                                          isCollapsed: true),
                                      maxLines: 1,
                                      controller: controller.categoryControl,
                                      cursorColor: theme.colorScheme.onBackground,
                                    ),


                                    const SizedBox(height: 14),

                                    FxButton.block(
                                      elevation: 0,
                                      borderRadiusAll: 4,
                                      onPressed: () async{
                                        //Get.toNamed(AppRoutes.home);

                                        String result = await controller.addCategory(controller.categoryControl.text);

                                        if(result == ServerResponse.success){
                                          if(context.mounted){
                                            await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const SuccessDialog(
                                                      icon: Icons.login,
                                                      message: "Thêm danh mục thành công!");
                                                });
                                          }
                                          Get.back();
                                        }else{
                                          if(context.mounted){
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const ErrorDialog(
                                                      icon: Icons.login,
                                                      message: "Thêm danh mục không thành công!");
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
                    icon: Icon(
                      Icons.add,
                      color: theme.primaryColor,
                    ))
              ],
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
                          itemCount: controller.listCategory.length,
                          itemBuilder: (BuildContext context, int index) {
                            Category category = controller.listCategory[index];
                            return categoryWidget(
                                category,
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

  Widget categoryWidget(Category category, BuildContext context) {
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
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
                          controller.categoryControl.text = category.name!;
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

                                        TextFormField(
                                          style: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                                          decoration: InputDecoration(
                                              floatingLabelBehavior: FloatingLabelBehavior.never,
                                              filled: true,
                                              isDense: true,
                                              fillColor: theme.cardTheme.color,
                                              prefixIcon: Icon(
                                                Icons.note_alt_outlined,
                                                color: theme.colorScheme.onBackground,
                                              ),
                                              hintText: "Tên danh mục",
                                              enabledBorder: outlineInputBorder,
                                              focusedBorder: outlineInputBorder,
                                              border: outlineInputBorder,
                                              contentPadding: FxSpacing.all(16),
                                              hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                                              isCollapsed: true),
                                          maxLines: 1,
                                          controller: controller.categoryControl,
                                          cursorColor: theme.colorScheme.onBackground,
                                        ),


                                        const SizedBox(height: 14),

                                        FxButton.block(
                                          elevation: 0,
                                          borderRadiusAll: 4,
                                          onPressed: () async{
                                            //Get.toNamed(AppRoutes.home);

                                            String result = await controller.updateCategory(category.id!,controller.categoryControl.text);

                                            if(result == ServerResponse.success){
                                              if(context.mounted){
                                                await showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return const SuccessDialog(
                                                          icon: Icons.login,
                                                          message: "Cập nhật danh mục thành công!");
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
                                                          message: "Cập nhật danh mục không thành công!");
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
                                "Cập nhật",
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
                    FxText.titleMedium(
                        category.name ?? "",
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
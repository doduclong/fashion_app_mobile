import 'dart:convert';
import 'dart:io';
import 'package:fashion_app/app/common/stateless/custom_dialog/error_dialog.dart';
import 'package:fashion_app/app/common/stateless/custom_text_field.dart';
import 'package:fashion_app/app/models/category.dart';
import 'package:fashion_app/app/models/product/size_product.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/manager/manager_product/add_product/add_product_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class AddProductPage extends GetView<AddProductController> {
  AddProductPage({Key? key}) : super(key: key);

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
    )

      : Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.white54,
        centerTitle: true,
        backgroundColor: const Color(0xffffffff),
        title: FxText.titleMedium(
          "THÊM SẢN PHẨM",
          color: theme.primaryColor,
        ),

        leading: IconButton(
            onPressed: () {
              Get.back();
              //Get.offAndToNamed(AppRoutes.home);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: theme.primaryColor,
            )),
        actions: [
          IconButton(
              onPressed: () async{
            File file = controller.file;
            String name = controller.nameTE.text;
            String describe = controller.describeTE.text;
            String price = controller.priceTE.text;

            //String result = await controller.add(file, name,  price, describe, controller.selectedCategory.value.id! , file.path.split('/').last.split('.')[0].toString(), jsonEncode(controller.sizes));
            String result = await controller.add(file, name,  price, describe, controller.selectedCategory.value.id! , file.path.split('/').last.split('.')[0].toString(), json.encode(controller.sizes));
            if(result == ServerResponse.success){
              Get.offAndToNamed(AppRoutes.home);
            }else{
              if(context.mounted){
                showDialog(
                    context: context,
                    builder: (context) {
                      return const ErrorDialog(
                          icon: Icons.login,
                          message: "Thêm sản phẩm không thành công!");
                    });
              }
            }
          }, icon: Icon(Icons.check, color: theme.primaryColor,))
        ],

      ),
      body: ListView(
        padding:
        FxSpacing.fromLTRB(20, FxSpacing.safeAreaTop(context) + 10, 20, 20),
        children: [
          Form(
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () async{
                  FilePickerResult? result =
                  await FilePicker.platform.pickFiles(
                    type: FileType.image,
                    allowMultiple: false,);
                  if (result != null && result.files.isNotEmpty) {
                    File file = File(result.files.first.path!);
                    controller.file = file;
                    controller.fileUrl.value = file.path;
                  }
                  else{

                  }
                },
                    child: FxText.bodyMedium(
                  "Chọn ảnh",
                  color: theme.colorScheme.onPrimary,
                ),
                  style: ButtonStyle(
                    backgroundColor:MaterialStateProperty.all<Color>(theme.primaryColor),
                  ),

                ),

                Obx(() {
                  if (controller.fileUrl.value.isNotEmpty) {
                    return
                    //   CachedNetworkImage(
                    //   imageUrl: controller.fileUrl.value,
                    //   placeholder: (context, url) => CircularProgressIndicator(),
                    //   errorWidget: (context, url, error) => Icon(Icons.error),
                    //   height: 200,
                    //   width: 200,
                    // );

                      Center(
                        child: Image.file(
                          File(controller.fileUrl.value),
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.cover, // Tuỳ chỉnh cách ảnh được hiển thị trong kích thước đã cho
                        ),
                      );
                  } else {
                    return Container(
                      width: 200,
                      height: 200,
                      color: Colors.grey,
                      child: Center(
                        child: Text('No Image'),
                      ),
                    );
                  }
                }),
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
                      hintText: "Tên sản phẩm",
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),
                      hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: controller.nameTE,
                  cursorColor: theme.colorScheme.onBackground,
                ),
                FxSpacing.height(20),
                TextFormField(
                  style: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      filled: true,
                      isDense: true,
                      fillColor: theme.cardTheme.color,
                      prefixIcon: Icon(
                        FeatherIcons.mail,
                        color: theme.colorScheme.onBackground,
                      ),
                      hintText: "Giá tiền",
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),
                      hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: controller.priceTE,
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
                      hintText: "Mô tả",
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      border: outlineInputBorder,
                      contentPadding: FxSpacing.all(16),
                      hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                      isCollapsed: true),
                  maxLines: 1,
                  controller: controller.describeTE,
                  cursorColor: theme.colorScheme.onBackground,
                ),
                FxSpacing.height(20),
                Container(
                  child: CustomTextField(
                    tap: () async{
                      if(context.mounted){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  backgroundColor:
                                  CustomTheme.gray,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.only(
                                          topLeft: Radius
                                              .circular(
                                              20),
                                          topRight:
                                          Radius.circular(
                                              20))),
                                  contentPadding:
                                  const EdgeInsets.all(10),
                                  alignment: Alignment
                                      .bottomCenter,
                                  insetPadding:
                                  EdgeInsets.zero,
                                  titlePadding:
                                  const EdgeInsets.all(
                                      0),
                                  title: Container(
                                    padding:
                                    const EdgeInsets
                                        .only(top: 5),
                                    decoration: BoxDecoration(
                                        color: CustomTheme
                                            .gray,
                                        borderRadius: const BorderRadius
                                            .only(
                                            topLeft: Radius
                                                .circular(
                                                20),
                                            topRight: Radius
                                                .circular(
                                                20))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: (){
                                              Get.back();
                                            },
                                            icon: Icon(Icons.check, color: customTheme.colorSuccess,)),
                                      ],
                                    ),
                                  ),
                                  content:
                                  Container(
                                    height: MediaQuery.of(context).size.height / 3,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                      controller.listCategory.length,
                                      itemBuilder: (_, int index) {
                                        Category category =
                                        controller
                                            .listCategory[index];
                                        return Obx(()=> GestureDetector(
                                          onTap: (){
                                            controller.selectedCategory.value = category;
                                            controller.categoryTextControl.text = category.name!;
                                            Get.back();
                                          },
                                          child: CheckboxListTile(
                                            checkboxShape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50)),
                                            title: FxText.bodyMedium(
                                              category.name!, color: theme.colorScheme.onBackground,),
                                            value: controller.selectedCategory.value.name == controller.listCategory[index].name,
                                            onChanged: (isChecked) {
                                              controller.selectedCategory.value =  controller.listCategory[index];
                                              controller.categoryTextControl.text = controller.listCategory[index].name!;
                                            },

                                          ),
                                        ));
                                      },
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                            height: 1,
                                            color: theme
                                                .colorScheme.onBackground
                                                .withOpacity(0.5));
                                      },
                                    ),
                                  ));
                            });
                      }
                    },
                    labelText: "Danh mục *",
                    controller: controller.categoryTextControl,
                    keyboardType: TextInputType.multiline,
                    obscureText: false,
                    readOnly: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () async {
                        if(context.mounted){
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    backgroundColor:
                                    CustomTheme.gray,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.only(
                                            topLeft: Radius
                                                .circular(
                                                20),
                                            topRight:
                                            Radius.circular(
                                                20))),
                                    contentPadding:
                                    const EdgeInsets.all(10),
                                    alignment: Alignment
                                        .bottomCenter,
                                    insetPadding:
                                    EdgeInsets.zero,
                                    titlePadding:
                                    const EdgeInsets.all(
                                        0),
                                    title: Container(
                                      padding:
                                      const EdgeInsets
                                          .only(top: 5),
                                      decoration: BoxDecoration(
                                          color: CustomTheme
                                              .gray,
                                          borderRadius: const BorderRadius
                                              .only(
                                              topLeft: Radius
                                                  .circular(
                                                  20),
                                              topRight: Radius
                                                  .circular(
                                                  20))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: (){
                                                Get.back();
                                              },
                                              icon: Icon(Icons.check, color: customTheme.colorSuccess,)),
                                        ],
                                      ),
                                    ),
                                    content:
                                    Container(
                                      height: MediaQuery.of(context).size.height / 3,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                        controller.listCategory.length,
                                        itemBuilder: (_, int index) {
                                          Category category =
                                          controller
                                              .listCategory[index];
                                          return Obx(()=> GestureDetector(
                                            onTap: (){
                                              controller.selectedCategory.value = category;
                                              controller.categoryTextControl.text = category.name!;
                                              Get.back();
                                            },
                                            child: CheckboxListTile(
                                              checkboxShape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(50)),
                                              title: FxText.bodyMedium(
                                                category.name!, color: theme.colorScheme.onBackground,),
                                              value: controller.selectedCategory.value.name == controller.listCategory[index].name,
                                              onChanged: (isChecked) {
                                                controller.selectedCategory.value =  controller.listCategory[index];
                                                controller.categoryTextControl.text = controller.listCategory[index].name!;
                                              },

                                            ),
                                          ));
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                              height: 1,
                                              color: theme
                                                  .colorScheme.onBackground
                                                  .withOpacity(0.5));
                                        },
                                      ),
                                    ));
                              });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          FxSpacing.height(20),
          ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: controller.sizes.length,
            itemBuilder: (_, int index) {
              SizeProduct size = controller.sizes[index];
              return Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FxText.bodyMedium("Kích cỡ: " + size.size!, color: theme.colorScheme.onBackground,),

                    FxText.bodyMedium("Số lượng: " + size.quantity!.toString(), color: theme.colorScheme.onBackground,),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(height: 0);
            },
          ),
          FxSpacing.height(20),
          FxButton.block(
            elevation: 0,
            borderRadiusAll: 4,
            onPressed: () async{
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
                                  hintText: "Kích cỡ",
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputBorder,
                                  border: outlineInputBorder,
                                  contentPadding: FxSpacing.all(16),
                                  hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                                  isCollapsed: true),
                              maxLines: 1,
                              controller: controller.sizeControl,
                              cursorColor: theme.colorScheme.onBackground,
                            ),
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
                                  hintText: "Số lượng",
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputBorder,
                                  border: outlineInputBorder,
                                  contentPadding: FxSpacing.all(16),
                                  hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                                  isCollapsed: true),
                              maxLines: 1,
                              controller: controller.quantityControl,
                              cursorColor: theme.colorScheme.onBackground,
                            ),

                            const SizedBox(height: 14),

                            FxButton.block(
                              elevation: 0,
                              borderRadiusAll: 4,
                              onPressed: () async{
                                 controller.addSize(controller.sizeControl.text, int.parse(controller.quantityControl.text));
                                 Get.back();
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
            splashColor: theme.colorScheme.onPrimary.withAlpha(28),
            backgroundColor: theme.colorScheme.primary,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(),
              child: FxText.labelLarge(
                "Thêm kích cỡ",
                fontWeight: 600,
                color: theme.colorScheme.onPrimary,
                letterSpacing: 0.4,
              ),
            ),
          ),
          // FxButton.block(
          //   elevation: 0,
          //   borderRadiusAll: 4,
          //   onPressed: () async{
          //     //Get.toNamed(AppRoutes.home);
          //     File file = controller.file;
          //     String name = controller.nameTE.text;
          //     String describe = controller.describeTE.text;
          //     String price = controller.priceTE.text;
          //
          //     String result = await controller.add(file, name, describe, price,1, file.path.split('/').last.split('.')[0].toString(), controller.sizes);
          //
          //     if(result == ServerResponse.success){
          //       Get.offAndToNamed(AppRoutes.home);
          //     }else{
          //       if(context.mounted){
          //         showDialog(
          //             context: context,
          //             builder: (context) {
          //               return const ErrorDialog(
          //                   icon: Icons.login,
          //                   message: "Thêm sản phẩm không thành công!");
          //             });
          //       }
          //     }
          //   },
          //   splashColor: theme.colorScheme.onPrimary.withAlpha(28),
          //   backgroundColor: theme.colorScheme.primary,
          //   child: Container(
          //     clipBehavior: Clip.antiAliasWithSaveLayer,
          //     decoration: BoxDecoration(),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         FxText.labelLarge(
          //           "Thêm",
          //           fontWeight: 600,
          //           color: theme.colorScheme.onPrimary,
          //           letterSpacing: 0.4,
          //         ),
          //         FxSpacing.width(8),
          //         Icon(
          //           FeatherIcons.arrowRight,
          //           color: theme.colorScheme.onPrimary,
          //           size: 20,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          FxSpacing.height(20),
        ],
      ),
    ));
  }
}
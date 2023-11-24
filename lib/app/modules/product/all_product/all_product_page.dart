import 'dart:convert';

import 'package:fashion_app/app/models/category.dart';
import 'package:fashion_app/app/models/product/product.dart';
import 'package:fashion_app/app/modules/product/all_product/all_product_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AllProductPage extends GetView<AllProductController>{

  AllProductPage({super.key});

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
              "SẢN PHẨM",
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
              Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: Icon(
                      MdiIcons.tune,
                      color: theme.primaryColor,
                    )),
              ),
              // IconButton(
              //   onPressed: (){
              //
              //   },
              //   icon: Icon(
              //   MdiIcons.tune,
              //   color: theme.colorScheme.primary,
              //   size: 22,
              // ),)
            ],
          ),

          endDrawer: Drawer(
            child:Column(
              children: [
                FxSpacing.height(20),
                FxText.bodyLarge("DANH MỤC", color: theme.colorScheme.onBackground,),
                Obx(()=> Expanded(
                  child: ListView.separated(
                    itemCount: controller.listCategory
                        .length,
                    itemBuilder: (_, int index) {
                      return _category(
                          controller.listCategory[index],
                          context);
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  ),
                )
                ),
              ],
            ),
          ),

          body:
          Obx(()=>controller.isLoading.value
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
                        itemCount: controller.listProduct.length,
                        itemBuilder: (BuildContext context, int index) {
                          Product product = controller.listProduct[index];
                          return singleForYouWidget(
                              product: product,
                              context: context
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
          ))),
    );
  }

  Widget _category(Category category, BuildContext context) {
    return ListTile(
      onTap: () async {

      },
      //leading:Icon(Icons.list),
      leading: SizedBox(
        width: 30,
        child: Row(
          children: [
            Visibility(
              visible: category.name!.toLowerCase().contains("Áo")
                  ? true
                  : false,
              child: Icon(
                FontAwesomeIcons.shirt,
                color: customTheme.learningCategory5,
              ),
            ),
            Visibility(
              visible: category.name!.toLowerCase().contains("Quần")
                  ? true
                  : false,
              child: Icon(
                FontAwesomeIcons.fileWord,
                color: theme.primaryColor,
              ),
            ),
            Visibility(
              visible: category.name!.toLowerCase().endsWith("Giày")
                  ? true
                  : false,
              child: Icon(
                FontAwesomeIcons.hatCowboy,
                color: customTheme.colorInfo,
              ),
            ),
            Visibility(
              visible: category.name!.toLowerCase().endsWith("Mũ")
                  ? true
                  : false,
              child: Icon(
                FontAwesomeIcons.hatCowboy,
                color: customTheme.learningCategory4,
              ),
            ),
            Visibility(
              visible: category.name!.toLowerCase().endsWith(".jpg")
                  ? true
                  : false,
              child: Icon(
                FontAwesomeIcons.hatCowboy,
                color: customTheme.learningCategory4,
              ),
            ),
            Visibility(
              visible: category.name!.toLowerCase().endsWith(".png")
                  ? true
                  : false,
              child: Icon(
                FontAwesomeIcons.hatCowboy,
                color: customTheme.learningCategory4,
              ),
            ),
            Visibility(
              visible: category.name!.toLowerCase().contains("Áo") ||
                  category.name!.toLowerCase().contains("Quần") ||
                  category.name!.toLowerCase().contains("Mũ") ||
                  category.name!.toLowerCase().contains("Váy") ||
                  category.name!.toLowerCase().contains(".jpg") ||
                  category.name!.toLowerCase().contains(".png")
                  ? false
                  : true,
              child: Icon(
                Icons.file_copy_outlined,
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
      title: FxText.bodyMedium(
        category.name!,
        color: theme.colorScheme.onBackground,
      ),
    );
  }

  Widget singleForYouWidget(
      {required Product product,
        BuildContext? context}) {
    return FxContainer.bordered(
      color: Colors.transparent,
      paddingAll: 8,
      borderRadiusAll: 4,
      margin: FxSpacing.bottom(8),
      onTap: () {
        controller.selectedProduct.value = product;
        Get.toNamed(AppRoutes.detailProduct);
      },
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child:
            Image.memory(const Base64Decoder().convert(product.galleries![0].image!), height: 50, fit: BoxFit.fill,),
          ),
          Expanded(
            child: FxContainer.none(
              height: 50,
              color: Colors.transparent,
              margin: FxSpacing.left(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FxText.titleMedium(
                      product.name ?? "",
                      fontWeight: 600,
                      color: theme.colorScheme.onBackground
                  ),
                  FxText.bodyMedium(NumberFormat.decimalPattern().format(product.price ?? 0), fontWeight: 700, color: theme.colorScheme.onBackground)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
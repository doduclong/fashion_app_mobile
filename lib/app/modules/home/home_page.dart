import 'dart:convert';

import 'package:fashion_app/app/common/stateless/custom_dialog/custom_loading.dart';
import 'package:fashion_app/app/models/product/product.dart';
import 'package:fashion_app/app/modules/home/home_controller.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/app/modules/search/search_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  ThemeData theme = AppTheme.theme;
  CustomTheme customTheme = AppTheme.customTheme;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              //padding: FxSpacing.zero,
              children: <Widget>[
                Container(
                  padding: FxSpacing.nBottom(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FxText.titleMedium("Xin chào ${Get.find<LoginController>().storedUsername.value}!",
                          letterSpacing: 0, fontWeight: 600, color: theme.colorScheme.onBackground,),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.cart);
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: theme.colorScheme.onBackground,
                            ),
                            Obx(()=>Visibility(
                              visible: controller.cartItems > 0,
                              child: Positioned(
                                right: -2,
                                top: -2,
                                child: FxContainer.rounded(
                                  padding: FxSpacing.zero,
                                  height: 14,
                                  width: 14,
                                  color: theme.colorScheme.primary,
                                  child: Center(
                                    child: FxText.labelSmall(
                                      controller.cartItems.toString(),
                                      color: theme.colorScheme.onPrimary,
                                      fontSize: 9,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                FxContainer.bordered(
                  paddingAll: 16,
                  borderRadiusAll: 4,
                  margin: FxSpacing.nBottom(24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FxContainer(
                                padding: FxSpacing.xy(12, 8),
                                color: theme.colorScheme.primary.withAlpha(28),
                                borderRadiusAll: 4,
                                child: FxText.bodySmall("Xu hướng",
                                    color: theme.colorScheme.primary,
                                    letterSpacing: 0.3,
                                    fontWeight: 600),
                              ),
                              FxText.labelMedium("Colorful Sandal",
                                  fontWeight: 600, letterSpacing: 0, color: theme.colorScheme.onBackground),
                              FxText.bodySmall("700,000",
                                  fontWeight: 600, letterSpacing: 0, color: theme.colorScheme.onBackground)
                            ],
                          ),
                        ),
                      ),
                      const FxContainer(
                        paddingAll: 0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        borderRadiusAll: 4,
                        child: Image(
                          image: AssetImage(
                              './assets/images/apps/shopping/product/product-8.jpg'),
                          width: 125,
                          height: 125,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: FxSpacing.nBottom(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FxText.bodyLarge("Bán chạy",
                          fontWeight: 600, letterSpacing: 0, color: theme.colorScheme.onBackground),
                      InkWell(
                        onTap: (){
                          Get.toNamed(AppRoutes.allProduct);
                        },
                        child: FxText.bodySmall("Xem tất cả",
                            color: theme.colorScheme.primary, letterSpacing: 0, ),
                      )
                    ],
                  ),
                ),
                FxSpacing.height(24),
                Obx(()=>controller.isLoading.value
                    ? CustomCircularIndicator()
                : SizedBox(
                  height: 170,
                  child:Obx(()=> ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.listProduct.length,
                    itemBuilder: (_, int index) {
                      Product product = controller.listProduct[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: singleItemWidget(
                            product: product,
                            context: context
                        ),
                      );
                    },
                  )),
                ),),
                Container(
                  margin: FxSpacing.nBottom(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FxText.bodyLarge("Dành cho bạn", fontWeight: 600, letterSpacing: 0, color: theme.colorScheme.onBackground),
                      FxText.bodySmall(
                        "Xem tất cả",
                        letterSpacing: 0,
                        color: theme.colorScheme.primary,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: FxSpacing.nBottom(24),
                  child:
                  Obx(()=>ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
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
                  ))
                ),
              ],
            ),
          )),
    );
  }

  Widget singleItemWidget(
      {required Product product,
        BuildContext? context}) {
    //String key = Generator.randomString(10);
    return InkWell(
      onTap: () {
        Get.find<SearchProductController>().selectedProduct.value = product;
        Get.toNamed(AppRoutes.detailProduct);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child:
            Image.memory(const Base64Decoder().convert(product.galleries![0].image!), height: 120, fit: BoxFit.fill,),
            // Image.asset(
            //   image,
            //   height: 120,
            //   fit: BoxFit.fill,
            // ),
          ),
          Container(
            margin: FxSpacing.top(8),
            child: FxText.bodyMedium(product.name ?? "",
                letterSpacing: 0, muted: true, fontWeight: 600, color: theme.colorScheme.onBackground),
          ),
          FxText.bodyMedium(NumberFormat.decimalPattern().format(product.price), color: theme.colorScheme.onBackground),
        ],
      ),
    );
  }

  Widget singleSellerWidget({required String image, required String name}) {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Image(
            image: AssetImage(image),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        FxSpacing.height(8),
        FxText.bodySmall(name, color: theme.colorScheme.onBackground)
      ],
    );
  }

  Widget singleForYouWidget(
      {required Product product,
        BuildContext? context}) {
    return FxContainer.bordered(
      color: Colors.transparent,
      paddingAll: 16,
      borderRadiusAll: 4,
      margin: FxSpacing.bottom(16),
      onTap: () {
        Get.find<SearchProductController>().selectedProduct.value = product;
        Get.toNamed(AppRoutes.detailProduct);
      },
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child:
            Image.memory(const Base64Decoder().convert(product.galleries![0].image!), height: 90, fit: BoxFit.fill,),
            // Image.asset(
            //   image,
            //   height: 90,
            //   fit: BoxFit.fill,
            // ),
          ),
          Expanded(
            child: FxContainer.none(
              height: 90,
              color: Colors.transparent,
              margin: FxSpacing.left(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FxText.titleMedium(
                    product.name!,
                    fontWeight: 600,
                      color: theme.colorScheme.onBackground
                  ),
                  FxText.bodyMedium(NumberFormat.decimalPattern().format(product.price), fontWeight: 700, color: theme.colorScheme.onBackground)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
import 'dart:convert';

import 'package:fashion_app/app/modules/product/product_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductPage extends GetView<ProductController>{

  ProductPage({super.key});

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
              "CHI TIẾT SẢN PHẨM",
              color: theme.primaryColor,
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child:
                          Image.memory(const Base64Decoder().convert(controller.selectedProduct.value.galleries![0].image!), height: 150, fit: BoxFit.cover,),
                          // Image.asset(
                          //   './assets/images/apps/shopping/product/product-10.jpg',
                          //   width: 150,
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                        FxSpacing.height(20),
                        FxText.bodyLarge(controller.selectedProduct.value.name ?? "", color: theme.colorScheme.onBackground,),
                        FxSpacing.height(8),
                        FxText.bodyMedium(NumberFormat.decimalPattern().format(controller.selectedProduct.value.price), color: theme.colorScheme.onBackground),
                        FxSpacing.height(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FxProgressBar(
                                width: 100,
                                height: 5,
                                activeColor: theme.colorScheme.primary,
                                inactiveColor:
                                theme.colorScheme.onBackground.withAlpha(100),
                                progress: 0.6),
                            FxSpacing.width(20),
                            FxText.bodySmall("123 Items",color: theme.colorScheme.onBackground,),
                          ],
                        ),
                        Container(
                          margin: FxSpacing.top(32),
                          child: FxText.bodyLarge(controller.selectedProduct.value.describe ?? "", color: theme.colorScheme.onBackground,)
                        ),
                      ],
                    ),
                  ),
                ),
                FxContainer.bordered(
                  paddingAll: 24,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                FxText.bodyMedium(
                                  "Số lượng",
                                  xMuted: true,
                                  color: theme.colorScheme.onBackground,
                                ),
                                FxSpacing.height(8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                        onPressed: (){
                                          if(controller.quantity.value>0){
                                            controller.decreaseQuantity();
                                          }

                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          size: 20,
                                          color: theme.colorScheme.onBackground
                                              .withAlpha(200),
                                        )),
                                    FxSpacing.width(4),
                                    FxText.titleMedium(controller.quantity.value.toString(), color: theme.colorScheme.onBackground,),
                                    FxSpacing.width(4),
                                    IconButton(
                                        onPressed: (){
                                          controller.increaseQuantity();

                                      },
                                        icon: Icon(
                                          Icons.add,
                                      size: 20,
                                      color: theme.colorScheme.onBackground
                                          .withAlpha(200),
                                    )),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      FxSpacing.height(24),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FxButton(
                              elevation: 2,
                              padding: FxSpacing.y(12),
                              borderRadiusAll: 4,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    MdiIcons.cartPlus,
                                    color: theme.colorScheme.onPrimary,
                                    size: 20,
                                  ),
                                  FxSpacing.width(4),
                                  FxText.bodyLarge(
                                    "300,000",
                                    letterSpacing: 0.4,
                                    color: theme.colorScheme.onPrimary,
                                    fontWeight: 600,
                                  )
                                ],
                              ),
                              onPressed: () {

                              },
                            ),
                          ),
                          FxSpacing.width(20),
                          FxContainer(
                            padding: FxSpacing.xy(12, 12),
                            borderRadiusAll: 4,
                            color: theme.colorScheme.primary.withAlpha(40),
                            child: Icon(
                              MdiIcons.shoppingOutline,
                              size: 24,
                              color: theme.colorScheme.primary,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

              ],
            ),
          ))),
    );
  }
}
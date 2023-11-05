import 'package:fashion_app/app/models/cart/cart_detail.dart';
import 'package:fashion_app/app/modules/cart/cart_controller.dart';
import 'package:fashion_app/app/modules/order/order_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderPage extends GetView<OrderController> {

  OrderPage({super.key});

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
              "GIỎ HÀNG",
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
                  child: Container(
                      decoration: BoxDecoration(
                          color: theme.colorScheme.onPrimary,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      padding: FxSpacing.all(10),
                      child:

                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: Get.find<CartController>().listCartDetail.length,
                        itemBuilder: (BuildContext context, int index) {
                          CartDetail cartDetail = Get.find<CartController>().listCartDetail[index];
                          return Container(
                            child: singleForYouWidget(
                                cartDetail,context
                            ),
                          );
                        },
                      )
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 7,
                          child: FxText.bodyMedium(
                            "Tổng thanh toán: ${NumberFormat.decimalPattern().format(Get.find<CartController>().total())}",
                            color: theme.colorScheme.primary,
                          ),
                        ),

                        Expanded(
                          flex: 3,
                          child: FxContainer(
                            onTap: () {
                              //controller.decrement(cart);
                            },
                            paddingAll: 4,
                            borderRadiusAll: 2,
                            border: Border.all(
                                color: theme.colorScheme.primary.withAlpha(120)),
                            color: theme.colorScheme.primary,

                            child: Center(
                              child: FxText.bodyLarge(
                                "Đặt hàng",
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ))),
    );
  }


  Widget singleForYouWidget(
      CartDetail cart,
      BuildContext? context) {
    return FxContainer.bordered(
      color: Colors.transparent,
      paddingAll: 8,
      borderRadiusAll: 4,
      margin: FxSpacing.bottom(8),
      onTap: () {
      },
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            child: Image.asset(
              cart.product!.description ?? "",
              height: 80,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: FxContainer.none(
              height: 80,
              color: Colors.transparent,
              margin: FxSpacing.left(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FxText.titleMedium(
                      cart.product!.name ?? "",
                      fontWeight: 600,
                      color: theme.colorScheme.onBackground
                  ),
                  FxText.bodyMedium(NumberFormat.decimalPattern().format(cart.product!.price), fontWeight: 700, color: theme.colorScheme.onBackground),
                  FxText.bodyMedium(
                    cart.quantity.toString(),
                    color: theme.colorScheme.onBackground,
                    fontWeight: 700,
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
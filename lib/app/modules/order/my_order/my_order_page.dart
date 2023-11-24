import 'dart:convert';
import 'package:fashion_app/app/models/order/order.dart';
import 'package:fashion_app/app/modules/order/my_order/my_order_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyOrderPage extends GetView<MyOrderController> {

  MyOrderPage({super.key});

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
              "ĐƠN HÀNG CỦA TÔI",
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
                        itemCount: controller.myOrders.length,
                        itemBuilder: (_, int index) {
                          Order order = controller.myOrders[index];
                          return Container(
                            child: orderWidget(
                                order,context
                            ),
                          );
                        },
                      )
                  ),
                ),
              ],
            ),
          ))),
    );
  }


  Widget orderWidget(
      Order order,
      BuildContext? context) {
    return FxContainer.bordered(
      color: Colors.transparent,
      paddingAll: 8,
      borderRadiusAll: 4,
      margin: FxSpacing.bottom(8),
      onTap: () {
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: order.listOrderDetail!.length,
            itemBuilder: (_, int index) {
              //Order order = order.listOrderDetail![index];
              return Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      child: Image.memory(const Base64Decoder().convert(order.listOrderDetail![index].galleries![0].image ?? ""), height: 80, fit: BoxFit.fill,),
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
                                order.listOrderDetail![index].productName ?? "",
                                fontWeight: 600,
                                color: theme.colorScheme.onBackground
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FxText.titleMedium(
                                    order.listOrderDetail![index].size ?? "",
                                    muted: true,
                                    color: theme.colorScheme.onBackground
                                ),
                                FxText.bodyMedium(
                                  "x${order.listOrderDetail![index].quantity}",
                                  color: theme.colorScheme.onBackground,
                                  fontWeight: 700,
                                ),
                              ],
                            ),

                            FxText.bodyMedium(NumberFormat.decimalPattern().format(order.listOrderDetail![index].price), fontWeight: 700, color: theme.colorScheme.onBackground),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxText.titleMedium("Thành tiền: ", color: theme.colorScheme.onBackground,),
              FxText.titleMedium(NumberFormat.decimalPattern().format(order.totalMoney), color: theme.colorScheme.onBackground,),
            ],
          ),

          const Divider(),

          Visibility(
            visible:order.status == "NEW",
              child: FxText.titleMedium("Chờ xác nhận",
                color: theme.primaryColor,)),
          Visibility(
              visible:order.status == "HOLD",
              child: FxText.titleMedium("Đang chuẩn bị hàng",
                color: theme.primaryColor,)),
          Visibility(
              visible:order.status == "SHIPPING",
              child: FxText.titleMedium("Đang giao hàng",
                color: theme.primaryColor,)),
          Visibility(
              visible:order.status == "DELIVERY",
              child: FxText.titleMedium("Giao hàng thành công",
                color: theme.primaryColor,)),

          Visibility(
              visible:order.status == "CANCELLED",
              child: FxText.titleMedium("Đã hủy",
                color: theme.primaryColor,)),

          const Divider(),
          Align(
            alignment: Alignment.centerRight,
              child: FxText.bodySmall(order.timeOrder!,muted: true, color: theme.colorScheme.onBackground,)),
        ],
      ),
    );
  }
}
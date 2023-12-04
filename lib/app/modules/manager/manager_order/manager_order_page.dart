import 'dart:convert';

import 'package:fashion_app/app/common/stateless/custom_dialog/error_dialog.dart';
import 'package:fashion_app/app/common/stateless/custom_dialog/success_dialog.dart';
import 'package:fashion_app/app/models/order/order.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/manager/manager_order/manager_order_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
class ManagerOrderPage extends GetView<ManagerOrderController> {


  ManagerOrderPage({super.key});

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
              "QUẢN LÝ ĐƠN HÀNG",
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
      BuildContext context) {
    return GestureDetector(
      onLongPress: () async{
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
                                                prefixIcon: Icon(Icons.signal_wifi_statusbar_4_bar),
                                                labelText: "Trạng thái đơn hàng",
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
                                              controller.status.value.isEmpty
                                                  ? null
                                                  : controller.status.value,
                                              isDense: true,
                                              items: controller.statusList
                                                  .map((value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                controller.status.value =
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

                                            String result = await controller.setStatusOrder(controller.status.value);

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
                    ],
                  ) );

            });
      },
      child: FxContainer.bordered(
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
            Row(
              children: [
                const Icon(Icons.person_2_outlined),
                FxSpacing.width(8),
                Flexible(child: FxText.titleMedium("${order.receiverName}", color: theme.colorScheme.onBackground,)),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.phone),
                FxSpacing.width(8),
                Flexible(child: FxText.titleMedium("${order.receiverPhone}", color: theme.colorScheme.onBackground,)),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.home_outlined),
                FxSpacing.width(8),
                Flexible(child: FxText.titleMedium("${order.receiverAddress}", color: theme.colorScheme.onBackground,)),
              ],
            ),
            Visibility(
                visible: order.note != "",
                child: const Divider()),
            Visibility(
              visible: order.note != "",
              child: Row(
                children: [
                  const Icon(Icons.note_alt_outlined),
                  FxSpacing.width(8),
                  Flexible(child: FxText.titleMedium("${order.note}", color: theme.colorScheme.onBackground,)),
                ],
              ),
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
      ),
    );
  }
}
import 'dart:convert';
import 'package:fashion_app/app/common/stateless/custom_dialog/confirm_dialog.dart';
import 'package:fashion_app/app/common/stateless/custom_dialog/error_dialog.dart';
import 'package:fashion_app/app/common/stateless/custom_dialog/success_dialog.dart';
import 'package:fashion_app/app/models/cart/cart_detail.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/cart/cart_controller.dart';
import 'package:fashion_app/app/modules/order/order_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderPage extends GetView<OrderController> {

  OrderPage({super.key});

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
              "ĐẶT HÀNG",
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
                  flex: 9,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.onPrimary,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16))),
                              padding: FxSpacing.all(10),
                              child:
                                FxContainer.bordered(
                                  color: Colors.transparent,
                                  paddingAll: 8,
                                  borderRadiusAll: 4,
                                  margin: FxSpacing.bottom(8),
                                  onTap: () {
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                          child: Icon(Icons.location_on_outlined,
                                            color: theme.primaryColor,)),
                                      Expanded(
                                        flex: 8,
                                          child:Obx(()=> Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              FxText.bodyLarge("Địa chỉ nhận hàng ", color: theme.colorScheme.onBackground,),
                                              controller.listDeliveryAddress.isNotEmpty
                                              ? Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  FxSpacing.height(8),
                                                  FxText.bodyMedium(
                                                    controller.selectedAddress.value.fullName ?? "",
                                                    color: theme.colorScheme.onBackground,
                                                    fontWeight: 600,
                                                  ),
                                                  FxSpacing.height(8),
                                                  FxText.bodyMedium(
                                                    controller.selectedAddress.value.phoneNumber ?? "",
                                                    color: theme.colorScheme.onBackground,
                                                    fontWeight: 600,
                                                  ),
                                                  FxSpacing.height(8),
                                                  FxText.bodyMedium(
                                                    controller.selectedAddress.value.address ?? "",
                                                    color: theme.colorScheme.onBackground,
                                                    fontWeight: 600,
                                                  ),
                                                ],
                                              ) : Container(),
                                            ],
                                          ))),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          onPressed: (){
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                      backgroundColor: CustomTheme.gray,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(0),
                                                              topRight: Radius.circular(0))),
                                                      contentPadding: const EdgeInsets.only(
                                                          top: 20, left: 10, right: 10, bottom: 10),
                                                      alignment: Alignment.center,
                                                      insetPadding: EdgeInsets.zero,
                                                      titlePadding: const EdgeInsets.all(0),
                                                      title: Container(
                                                        padding: const EdgeInsets.only(top: 20),
                                                        decoration: BoxDecoration(
                                                            color: CustomTheme.gray,
                                                            borderRadius: const BorderRadius.only(
                                                                topLeft: Radius.circular(10),
                                                                topRight: Radius.circular(10))),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const SizedBox(width: 32,),
                                                            FxText.titleMedium(
                                                              "Chọn địa chỉ",
                                                              color: theme.primaryColor,
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                icon: Icon(
                                                                  Icons.close,
                                                                  color: customTheme.colorError,
                                                                )),

                                                          ],
                                                        ),
                                                      ),
                                                      content: SizedBox(
                                                        height: MediaQuery.of(context).size.height,
                                                        width: double.maxFinite,
                                                        child: ListView.builder(
                                                          itemCount: controller.listDeliveryAddress.length,
                                                          itemBuilder: (_, int index) {
                                                            return
                                                              Obx(() => FxCard(
                                                                margin: FxSpacing.nTop(8),
                                                                paddingAll: 0,
                                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                borderRadiusAll: 10,
                                                                child: FxContainer(
                                                                  color: customTheme.onInfo,
                                                                  paddingAll: 0,
                                                                  child: CheckboxListTile(
                                                                    checkboxShape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(50)),
                                                                    title: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        FxText.bodyMedium(
                                                                          controller.listDeliveryAddress[index].fullName!, color: theme.colorScheme.onBackground,),

                                                                        FxText.bodyMedium(
                                                                          controller.listDeliveryAddress[index].phoneNumber!, color: theme.colorScheme.onBackground,),

                                                                        FxText.bodyMedium(
                                                                          controller.listDeliveryAddress[index].address!, color: theme.colorScheme.onBackground,),
                                                                      ],
                                                                    ),
                                                                    value: controller.selectedAddress.value.id == controller.listDeliveryAddress[index].id,
                                                                    onChanged: (isChecked) {
                                                                      controller.selectedAddress.value =  controller.listDeliveryAddress[index];
                                                                      controller.fullNameControl.text = controller.listDeliveryAddress[index].fullName!;
                                                                      controller.phoneNumberControl.text = controller.listDeliveryAddress[index].phoneNumber!;
                                                                      controller.addressControl.text = controller.listDeliveryAddress[index].address!;
                                                                    },

                                                                  ),
                                                                ),
                                                              ));
                                                          },
                                                        ),
                                                      ),);
                                                });


                                          },
                                          icon: Icon(Icons.arrow_forward_ios,
                                            color: theme.primaryColor,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                            child: TextFormField(
                              style: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                              decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  filled: true,
                                  isDense: true,
                                  fillColor: theme.cardTheme.color,
                                  prefixIcon: Icon(
                                    Icons.person_2_outlined,
                                    color: theme.colorScheme.onBackground,
                                  ),
                                  hintText: "Tên người nhận",
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputBorder,
                                  border: outlineInputBorder,
                                  contentPadding: FxSpacing.all(16),
                                  hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                                  isCollapsed: true),
                              maxLines: 1,
                              controller: controller.fullNameControl,
                              validator: controller.validatePassword,
                              cursorColor: theme.colorScheme.onBackground,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                            child: TextFormField(
                              style: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                                keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  filled: true,
                                  isDense: true,
                                  fillColor: theme.cardTheme.color,
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: theme.colorScheme.onBackground,
                                  ),
                                  hintText: "Số điện thoại",
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputBorder,
                                  border: outlineInputBorder,
                                  contentPadding: FxSpacing.all(16),
                                  hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                                  isCollapsed: true),
                              maxLines: 1,
                              controller: controller.phoneNumberControl,
                              validator: controller.validatePassword,
                              cursorColor: theme.colorScheme.onBackground,
                              //inputFormatters: [],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                            child: TextFormField(
                              style: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                              decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  filled: true,
                                  isDense: true,
                                  fillColor: theme.cardTheme.color,
                                  prefixIcon: Icon(
                                    Icons.home_outlined,
                                    color: theme.colorScheme.onBackground,
                                  ),
                                  hintText: "Địa chỉ",
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputBorder,
                                  border: outlineInputBorder,
                                  contentPadding: FxSpacing.all(16),
                                  hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                                  isCollapsed: true),
                              maxLines: 1,
                              controller: controller.addressControl,
                              validator: controller.validatePassword,
                              cursorColor: theme.colorScheme.onBackground,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10,),
                            child: TextFormField(
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
                                  hintText: "Ghi chú",
                                  enabledBorder: outlineInputBorder,
                                  focusedBorder: outlineInputBorder,
                                  border: outlineInputBorder,
                                  contentPadding: FxSpacing.all(16),
                                  hintStyle: FxTextStyle.bodyMedium(color: theme.colorScheme.onBackground),
                                  isCollapsed: true),
                              maxLines: 1,
                              controller: controller.noteControl,
                              cursorColor: theme.colorScheme.onBackground,
                            ),
                          ),

                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: theme.colorScheme.onPrimary,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16))),
                                padding: FxSpacing.only(left: 10, right: 10, top: 10, bottom: 0),
                                child:

                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  //shrinkWrap: true,
                                  itemCount: Get.find<CartController>().selectedCartDetails.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    CartDetail cartDetail = Get.find<CartController>().selectedCartDetails[index];
                                    return Container(
                                      child: singleForYouWidget(
                                          cartDetail,context
                                      ),
                                    );
                                  },
                                )
                            ),
                          ),



                        ],
                      ),
                    ),
                  ),
                ),



                Expanded(
                  flex: 1,
                  child: Padding(
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
                              onTap: () async{
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ConfirmDialog(
                                        title: "Xác nhận đặt hàng",
                                        message:
                                        "Bạn muốn đặt đơn hàng này?",
                                        btnOkOnPress: () async{
                                          String result = await controller.order(controller.listSelectedItem.value);
                                          if(result == ServerResponse.success){
                                            if (context.mounted) {
                                              await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return const SuccessDialog(
                                                        icon: Icons.add_shopping_cart,
                                                        message:
                                                        "Đặt hàng thành công!");
                                                  });
                                              Get.offNamedUntil(AppRoutes.myOrder, (route) => route.isFirst);
                                            }
                                          }else{
                                            if (context.mounted) {
                                              await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return const ErrorDialog(
                                                        icon: Icons.add_shopping_cart,
                                                        message:
                                                        "Đã xảy ra lỗi!");
                                                  });
                                            }
                                          }
                                        });
                                    });
                              },
                              paddingAll: 4,
                              borderRadiusAll: 2,
                              border: Border.all(
                                  color: theme.colorScheme.primary.withAlpha(120)),
                              color: theme.colorScheme.primary,

                              child: Center(
                                child: FxText.bodyLarge(
                                  "Xác nhận",
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
            child: Image.memory(const Base64Decoder().convert(cart.product!.galleries![0].image ?? ""), height: 80, fit: BoxFit.fill,),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        "Kích thước: ${cart.size}",
                        color: theme.colorScheme.onBackground,
                        fontWeight: 700,
                      ),
                      FxText.bodyMedium(
                        "Số lượng: ${cart.quantity}",
                        color: theme.colorScheme.onBackground,
                        fontWeight: 700,
                      ),
                    ],
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
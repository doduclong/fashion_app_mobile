import 'package:fashion_app/app/common/stateless/custom_dialog/error_dialog.dart';
import 'package:fashion_app/app/common/stateless/custom_dialog/success_dialog.dart';
import 'package:fashion_app/app/models/delivery_address_model.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/app/modules/setting/delivery_address/delivery_address_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DeliveryAddressPage extends GetView<DeliveryAddressController> {

  DeliveryAddressPage({super.key});

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
              "ĐỊA CHỈ CỦA TÔI",
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
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  contentPadding: const EdgeInsets.only(
                                      top: 20, left: 10, right: 10, bottom: 10),
                                  alignment: Alignment.bottomCenter,
                                  insetPadding: EdgeInsets.zero,
                                  titlePadding: const EdgeInsets.all(0),
                                  title: Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                        color: CustomTheme.gray,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20))),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(width: 32,),
                                        FxText.titleMedium(
                                          "Thêm địa chỉ",
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
                                  content: SingleChildScrollView(
                                    child: Form(
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        //key: controller.formKey,
                                        child: Column(
                                          //mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            FxTextField(
                                              controller: controller.fullNameControl,
                                              focusedBorderColor:
                                              theme.primaryColor,
                                              cursorColor: theme
                                                  .colorScheme.onBackground,
                                              textFieldStyle:
                                              FxTextFieldStyle.outlined,
                                              textColor: theme
                                                  .colorScheme.onBackground,
                                              labelText:
                                              'Tên người nhận ...',
                                              labelStyle: FxTextStyle.bodySmall(
                                                  color: theme
                                                      .colorScheme.onBackground,
                                                  muted: true),
                                              floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                              filled: true,
                                              fillColor:
                                              theme.scaffoldBackgroundColor,
                                            ),
                                            FxSpacing.height(8),
                                            FxTextField(
                                              controller: controller.phoneNumberControl,
                                              focusedBorderColor:
                                              theme.primaryColor,
                                              cursorColor: theme
                                                  .colorScheme.onBackground,
                                              textFieldStyle:
                                              FxTextFieldStyle.outlined,
                                              textColor: theme
                                                  .colorScheme.onBackground,
                                              labelText:
                                              'Số điện thoại ...',
                                              labelStyle: FxTextStyle.bodySmall(
                                                  color: theme
                                                      .colorScheme.onBackground,
                                                  muted: true),
                                              keyboardType: TextInputType.number,
                                              floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                              filled: true,
                                              fillColor:
                                              theme.scaffoldBackgroundColor,
                                            ),
                                            FxSpacing.height(8),
                                            FxTextField(
                                              controller: controller.addressControl,
                                              focusedBorderColor:
                                              theme.primaryColor,
                                              cursorColor: theme
                                                  .colorScheme.onBackground,
                                              textFieldStyle:
                                              FxTextFieldStyle.outlined,
                                              textColor: theme
                                                  .colorScheme.onBackground,
                                              labelText:
                                              'Địa chỉ nhận hàng ...',
                                              labelStyle: FxTextStyle.bodySmall(
                                                  color: theme
                                                      .colorScheme.onBackground,
                                                  muted: true),
                                              floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                              filled: true,
                                              fillColor:
                                              theme.scaffoldBackgroundColor,
                                            ),
                                            FxSpacing.height(8),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  shape:
                                                  MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                    ),
                                                  ),
                                                  //backgroundColor: WidgetColor.primaryColor,
                                                ),
                                                child: FxText.bodyLarge("Thêm"),
                                                onPressed: () async {
                                                  String fullName =
                                                      controller
                                                          .fullNameControl
                                                          .text;
                                                  String phoneNumber =
                                                      controller
                                                          .phoneNumberControl
                                                          .text;
                                                  String address =
                                                      controller
                                                          .addressControl
                                                          .text;
                                                  if (fullName.isNotEmpty && address.isNotEmpty && phoneNumber.isNotEmpty) {
                                                    String result = await controller
                                                        .createDeliveryAddress(address, fullName, address);
                                                    if (result == ServerResponse.success) {
                                                      if (context.mounted) {
                                                        Get.back();
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return const SuccessDialog(
                                                                  icon: Icons.location_on_outlined,
                                                                  message:
                                                                  "Thêm địa chỉ thành công");
                                                            });
                                                      }
                                                    }else{
                                                      if (context.mounted) {
                                                        Get.back();
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return const ErrorDialog(
                                                                  icon: Icons.location_on_outlined,
                                                                  message:
                                                                  "Đã có lỗi xảy ra! \n Vui lòng thử lại sau!");
                                                            });
                                                      }
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        )),
                                  ));
                            });


                    },
                    icon: Icon(
                      Icons.add_location_alt_outlined,
                      color: theme.primaryColor,
                    )),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controller.listDeliveryAddress.length,
              itemBuilder: (BuildContext context, int index) {
                DeliveryAddressModel deliveryAddress = controller.listDeliveryAddress[index];
                return Container(
                  child: _address(
                      deliveryAddress
                  ),
                );
              },
                separatorBuilder: (context, index) {
                  return const Divider(height: 0);
                },
            ),
          ),
        ));
  }

  Widget _address(DeliveryAddressModel address) {
    return FxContainer(
      paddingAll: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person_2_outlined,
                size: 20,
                color: theme.primaryColor,
              ),
              FxSpacing.width(8),
              FxText.bodyMedium(
                address.fullName ?? "",
                color: theme.colorScheme.onBackground,
                fontWeight: 600,
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 20,
                color: theme.primaryColor,
              ),
              FxSpacing.width(8),
              FxText.bodyMedium(
                address.phoneNumber ?? "",
                color: theme.colorScheme.onBackground,
                fontWeight: 600,
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 20,
                color: theme.primaryColor,
              ),
              FxSpacing.width(8),
              FxText.bodyMedium(
                address.address ?? "",
                color: theme.colorScheme.onBackground,
                fontWeight: 600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
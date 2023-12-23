import 'dart:convert';
import 'package:fashion_app/app/common/stateless/custom_dialog/error_dialog.dart';
import 'package:fashion_app/app/common/stateless/custom_dialog/success_dialog.dart';
import 'package:fashion_app/app/models/product/product.dart';
import 'package:fashion_app/app/models/response/server_response.dart';
import 'package:fashion_app/app/modules/product/product_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fashion_app/app/models/product/size_product.dart';

class ProductPage extends GetView<ProductController>{

  ProductPage({super.key});

  ThemeData theme = AppTheme.theme;
  CustomTheme customTheme = AppTheme.customTheme;

  //String selectedSize = "S";

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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Container(
                        //   height: 150,
                        //   width: 150,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     shrinkWrap: true,
                        //     itemCount: controller.selectedProduct.value.galleries!.length,
                        //     itemBuilder: (_, int index) {
                        //       return ClipRRect(
                        //         borderRadius: BorderRadius.all(Radius.circular(8)),
                        //         child:
                        //         Image.memory(
                        //           const Base64Decoder().convert(controller.selectedProduct.value.galleries![index].image!),
                        //           height: 150,
                        //           fit: BoxFit.cover,),
                        //       );
                        //     },
                        //   ),
                        // ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child:
                          Image.memory(
                            const Base64Decoder().convert(controller.selectedProduct.value.galleries![0].image!),
                            height: 150,
                            fit: BoxFit.cover,),
                        ),
                        FxSpacing.height(20),
                        FxText.bodyLarge(controller.selectedProduct.value.name ?? "", color: theme.colorScheme.onBackground,),
                        FxSpacing.height(8),
                        FxText.bodyMedium(NumberFormat.decimalPattern().format(controller.selectedProduct.value.price), color: theme.colorScheme.onBackground),
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
                                  "Kích thước",
                                  xMuted: true,
                                  color: theme.colorScheme.onBackground,
                                ),
                                FxSpacing.height(8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(()=>FxText.bodyMedium(
                                      controller.selectedSize.value,
                                      xMuted: true,
                                      color: theme.colorScheme.onBackground,
                                    )),
                                    IconButton(
                                        onPressed: (){
                                          _selectSizeSheet(controller.selectedProduct.value, context);
                                        },
                                        icon: Icon(Icons.arrow_drop_down_sharp, color: theme.colorScheme.onBackground,)),
                                  ],
                                )

                              ],
                            ),
                          ),

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
                                    NumberFormat.decimalPattern().format((controller.selectedProduct.value.price ?? 1) * controller.quantity.value),
                                    letterSpacing: 0.4,
                                    color: theme.colorScheme.onPrimary,
                                    fontWeight: 600,
                                  )
                                ],
                              ),
                              onPressed: () async{
                                String result = "";
                                if(controller.selectedProduct.value.name != null){
                                  result = await controller.addProductToCart(controller.selectedProduct.value.name ?? "", controller.quantity.value);
                                }
                                if(result == ServerResponse.success){
                                  if (context.mounted) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const SuccessDialog(
                                              icon: Icons.add_shopping_cart,
                                              message:
                                              "Đã thêm sản phẩm vào giỏ hàng!");
                                        });
                                  }
                                }else{
                                  if (context.mounted) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const ErrorDialog(
                                              icon: Icons.add_shopping_cart,
                                              message:
                                              "Đã xảy ra lỗi!");
                                        });
                                  }
                                }

                              },
                            ),
                          ),
                          FxSpacing.width(20),
                          FxContainer(
                            onTap: (){
                              Get.toNamed(AppRoutes.cart);
                            },
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

  void _selectSizeSheet(Product product, context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return FxContainer(
                padding: FxSpacing.xy(32, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: FxContainer.rounded(
                              paddingAll: 8,
                              color: customTheme.card,
                              child: Icon(
                                MdiIcons.close,
                                size: 20,
                                color: theme.colorScheme.onBackground,
                              )),
                        )
                      ],
                    ),

                    Expanded(
                        child: Obx(()=> ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.selectedProduct.value.sizes!.length,
                          shrinkWrap: true,
                          itemBuilder: (_, int index) {
                            SizeProduct size = controller.selectedProduct.value.sizes![index];
                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    controller.selectedSize.value = size.size ?? "";
                                    controller.existQuantity.value = size.quantity ?? 0;
                                  });
                                },
                                child: SingleSizeWidget(
                                  size: size.size ?? "",
                                  isAvailable: size.quantity! > 0 ? true : false,
                                  isSelected: controller.selectedSize.value == size.size,
                                ),
                              ),
                            );
                          },
                        )
                    ),),

                    Row(
                      children: [
                        FxText.bodyLarge("Còn lại: ${controller.existQuantity.value} sản phẩm", color: theme.colorScheme.onBackground,)
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: IntrinsicHeight(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: theme.colorScheme.primary,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        MdiIcons.imageSizeSelectSmall,
                                        color: theme.colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                  FxSpacing.height(8),
                                  FxText.bodyMedium("Hướng dẫn chọn size",
                                      fontWeight: 600, letterSpacing: 0, color: theme.colorScheme.onBackground,)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}

class SingleSizeWidget extends StatefulWidget {
  final String size;
  final bool isAvailable, isSelected;

  const SingleSizeWidget(
      {Key? key,
        required this.size,
        this.isAvailable = true,
        this.isSelected = false})
      : super(key: key);

  @override
  _SingleSizeWidgetState createState() => _SingleSizeWidgetState();
}

class _SingleSizeWidgetState extends State<SingleSizeWidget> {
  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(
            color: theme.primaryColor,
            width: 1.6),
        shape: BoxShape.circle,
        color: widget.isAvailable
            ? (widget.isSelected
            ? theme.colorScheme.primary
            : Colors.transparent)
            : customTheme.cardDark,
      ),
      child: Center(
        child: FxText.bodyLarge(widget.size.toString(),
            letterSpacing: -0.2,
            fontWeight: 600,
            color: (widget.isAvailable && widget.isSelected)
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onBackground),
      ),
    );
  }
}
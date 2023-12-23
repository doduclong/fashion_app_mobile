import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fashion_app/app/common/stateless/custom_dialog/custom_loading.dart';
import 'package:fashion_app/app/models/product/product.dart';
import 'package:fashion_app/app/modules/search/search_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchPage extends GetView<SearchProductController>{

  SearchPage({super.key});
  Timer? _debounce;
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
              "TÌM KIẾM",
              color: theme.primaryColor,
            ),
          ),

            body:
            Obx(()=>controller.isLoading.value
                ? CustomCircularIndicator()

                : Container(
              color: theme.scaffoldBackgroundColor,
              child: Column(
                //padding: FxSpacing.zero,
                children: <Widget>[
                  FxContainer(
                    borderRadiusAll: 4,
                    padding: FxSpacing.all(8),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            child: TextFormField(
                              controller: controller.searchTextControl,
                              onChanged: _onSearchChanged,
                              style: FxTextStyle.bodyLarge(
                                  letterSpacing: 0.1,
                                  color: theme.colorScheme.onBackground),
                              decoration: InputDecoration(
                                prefixIcon: IconButton(
                                    icon: const Icon(MdiIcons.magnify),
                                    onPressed: () {
                                      controller.searchProduct(controller.searchTextControl.text);
                                    },
                                    iconSize: 22,
                                    color: theme.primaryColor),

                                hintText: "Tìm kiếm",
                                hintStyle: FxTextStyle.titleSmall(
                                  letterSpacing: 0.1,
                                  color: theme.colorScheme.onBackground,
                                ),
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    borderSide: BorderSide.none),
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    borderSide: BorderSide.none),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor: customTheme.card,
                                suffixIcon: IconButton(
                                    icon: const Icon(Icons.image_outlined),
                                    onPressed: () async{
                                      ImagePicker picker = ImagePicker();

                                      XFile? image =
                                          await picker.pickImage(source: ImageSource.gallery);

                                      if (image != null) {
                                        File file = File(image.path);
                                        await controller.searchByImage(file);
                                      }
                                    },
                                    iconSize: 22,
                                    color: theme.primaryColor),
                                isDense: true,
                                contentPadding: const EdgeInsets.all(10),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              textCapitalization:
                              TextCapitalization.sentences,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  controller.listProduct.isNotEmpty
                   ? Expanded(
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
                  )
                  : Container(
                    child: FxText.bodyLarge("Không có sản phẩm phù hợp", color: theme.colorScheme.onBackground,),
                  ),
                ],
              ),
            ))),
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
          Container(
            width: 45,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child:
              Image.memory(const Base64Decoder().convert(product.galleries![0].image!), height: 50, fit: BoxFit.fill,),
            ),
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

  _onSearchChanged(String searchText) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      controller.searchTextControl.text = searchText;
      controller.searchProduct(searchText);
    });
  }
}
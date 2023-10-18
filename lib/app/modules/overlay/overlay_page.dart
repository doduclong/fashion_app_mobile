import 'package:fashion_app/app/modules/overlay/overlay_controller.dart';
import 'package:fashion_app/core/widget/icon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:get/get.dart';

class OverlayPage extends GetView<OverlayController> {
  OverlayPage({super.key, this.selectedPage});

  int? selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    controller.currentIndex.value = selectedPage!;
    return SafeArea(
        top: io.Platform.isAndroid ? true : false,
        child: Obx(() => Scaffold(
          resizeToAvoidBottomInset: false,
          body: controller.overlayViewSelect[controller.currentIndex.value],
          bottomNavigationBar: BottomAppBar(
            clipBehavior: Clip.hardEdge,
            shape: const CircularNotchedRectangle(),
            notchMargin: 10,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.onItemTapped(0);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: IconBottomBar(
                            selected: controller.currentIndex.value == 0 ? true : false,
                            text: "Trang chủ",
                            icon: Icons.home_outlined,
                          ),
                        ),
                      )),
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.onItemTapped(1);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5, right: 10),
                          child: IconBottomBar(
                            text: "Tìm kiếm",
                            icon: Icons.search,
                            selected: controller.currentIndex.value == 1 ? true : false,
                          ),
                        ),
                      )),
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.onItemTapped(2);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5, right: 10),
                          child: IconBottomBar(
                            text: "Giỏ hàng",
                            icon: Icons.shopping_cart_outlined,
                            selected: controller.currentIndex.value == 2 ? true : false,
                          ),
                        ),
                      )),
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.onItemTapped(3);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: IconBottomBar(
                            text: "Cài đặt",
                            icon: Icons.settings,
                            selected: controller.currentIndex.value == 3 ? true : false,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        )));
  }
}
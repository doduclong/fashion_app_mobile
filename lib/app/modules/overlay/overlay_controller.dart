import 'package:fashion_app/app/modules/home/home_page.dart';
import 'package:fashion_app/app/modules/search/search_page.dart';
import 'package:fashion_app/app/modules/setting/setting_page.dart';
import 'package:get/get.dart';

class OverlayController extends GetxController {
  final currentIndex = 0.obs;

  List overlayViewSelect = [
    HomePage(),
    SearchPage(),
    SettingPage(),
  ];

  onItemTapped(int index) async {
    currentIndex.value = index;
  }
}
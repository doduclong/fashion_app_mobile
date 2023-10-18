import 'package:fashion_app/app/modules/home/home_page.dart';
import 'package:get/get.dart';

class OverlayController extends GetxController {
  final currentIndex = 0.obs;

  List overlayViewSelect = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  onItemTapped(int index) async {
    currentIndex.value = index;
  }
}
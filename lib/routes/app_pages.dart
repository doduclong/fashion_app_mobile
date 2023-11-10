
import 'package:fashion_app/app/modules/login/login_binding.dart';
import 'package:fashion_app/app/modules/login/login_page.dart';
import 'package:fashion_app/app/modules/order/order_binding.dart';
import 'package:fashion_app/app/modules/order/order_page.dart';
import 'package:fashion_app/app/modules/overlay/overlay_binding.dart';
import 'package:fashion_app/app/modules/overlay/overlay_page.dart';
import 'package:fashion_app/app/modules/setting/delivery_address/delivery_address_binding.dart';
import 'package:fashion_app/app/modules/setting/delivery_address/delivery_address_page.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static const duration = 0;
  static final pages = [
    GetPage(
        name: AppRoutes.initial,
        page: () => LoginPage(),
        binding: LoginBinding(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: duration)),

    GetPage(
        name: AppRoutes.home,
        page: () => OverlayPage(selectedPage: 0),
        binding: OverlayBinding(),
        transitionDuration: const Duration(milliseconds: duration),
        transition: Transition.leftToRight),

    GetPage(
        name: AppRoutes.deliveryAddress,
        page: () => DeliveryAddressPage(),
        binding: DeliveryAddressBinding(),
        transitionDuration: const Duration(milliseconds: duration),
        transition: Transition.leftToRight),

    GetPage(
        name: AppRoutes.order,
        page: () => OrderPage(),
        binding: OrderBinding(),
        transitionDuration: const Duration(milliseconds: duration),
        transition: Transition.leftToRight),
  ];
}

import 'package:fashion_app/app/modules/cart/cart_binding.dart';
import 'package:fashion_app/app/modules/cart/cart_page.dart';
import 'package:fashion_app/app/modules/login/login_binding.dart';
import 'package:fashion_app/app/modules/login/login_page.dart';
import 'package:fashion_app/app/modules/manager/manager_binding.dart';
import 'package:fashion_app/app/modules/manager/manager_category/manager_category_binding.dart';
import 'package:fashion_app/app/modules/manager/manager_category/manager_category_page.dart';
import 'package:fashion_app/app/modules/manager/manager_order/manager_order_binding.dart';
import 'package:fashion_app/app/modules/manager/manager_order/manager_order_page.dart';
import 'package:fashion_app/app/modules/manager/manager_page.dart';
import 'package:fashion_app/app/modules/manager/manager_product/manager_product_binding.dart';
import 'package:fashion_app/app/modules/manager/manager_product/manager_product_page.dart';
import 'package:fashion_app/app/modules/manager/manager_user/manager_user_binding.dart';
import 'package:fashion_app/app/modules/manager/manager_user/manager_user_page.dart';
import 'package:fashion_app/app/modules/order/my_order/my_order_binding.dart';
import 'package:fashion_app/app/modules/order/my_order/my_order_page.dart';
import 'package:fashion_app/app/modules/order/order_binding.dart';
import 'package:fashion_app/app/modules/order/order_page.dart';
import 'package:fashion_app/app/modules/overlay/overlay_binding.dart';
import 'package:fashion_app/app/modules/overlay/overlay_page.dart';
import 'package:fashion_app/app/modules/product/all_product/all_product_binding.dart';
import 'package:fashion_app/app/modules/product/all_product/all_product_page.dart';
import 'package:fashion_app/app/modules/product/product_binding.dart';
import 'package:fashion_app/app/modules/product/product_page.dart';
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

    GetPage(
        name: AppRoutes.detailProduct,
        page: () => ProductPage(),
        binding: ProductBinding(),
        transitionDuration: const Duration(milliseconds: duration),
        transition: Transition.leftToRight),

    GetPage(
        name: AppRoutes.cart,
        page: () => CartPage(),
        binding: CartBinding(),
        transitionDuration: const Duration(milliseconds: duration),
        transition: Transition.leftToRight),

    GetPage(
        name: AppRoutes.allProduct,
        page: () => AllProductPage(),
        binding: AllProductBinding(),
        transitionDuration: const Duration(milliseconds: duration),
        transition: Transition.leftToRight),

    GetPage(
        name: AppRoutes.myOrder,
        page: () => MyOrderPage(),
        binding: MyOrderBinding(),
        transitionDuration: const Duration(milliseconds: duration),
        transition: Transition.leftToRight),

    GetPage(
        name: AppRoutes.manager,
        page: () => ManagerPage(),
        binding: ManagerBinding(),
        transitionDuration: const Duration(milliseconds: duration),
        transition: Transition.leftToRight),

    GetPage(
        name: AppRoutes.managerUser,
        page: () => ManagerUserPage(),
        binding: ManagerUserBinding(),
        transitionDuration: const Duration(milliseconds: duration),
        transition: Transition.leftToRight),

    GetPage(
        name: AppRoutes.managerProduct,
        page: () => ManagerProductPage(),
        binding: ManagerProductBinding(),
        transitionDuration: const Duration(milliseconds: duration),
        transition: Transition.leftToRight),

    GetPage(
        name: AppRoutes.managerOrder,
        page: () => ManagerOrderPage(),
        binding: ManagerOrderBinding(),
        transitionDuration: const Duration(milliseconds: duration),
        transition: Transition.leftToRight),

    GetPage(
        name: AppRoutes.managerCategory,
        page: () => ManagerCategoryPage(),
        binding: ManagerCategoryBinding(),
        transitionDuration: const Duration(milliseconds: duration),
        transition: Transition.leftToRight),
  ];
}
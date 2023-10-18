import 'package:fashion_app/app/data/enum/translations.dart';
import 'package:fashion_app/app/data/services/localization.dart';
import 'package:fashion_app/app/modules/login/login_binding.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/init_binding.dart';
import 'package:fashion_app/routes/app_pages.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:fashion_app/screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
  // runApp(
  //   const MaterialApp(home: MyApp()), // use MaterialApp
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Get.put(ScreenSizeController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: LoginBinding(),
      initialRoute: AppRoutes.initial,
      getPages: AppPages.pages,
      locale: LocalizationService.getLocaleFromLanguage(),
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: AppTranslations(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('vi'), Locale('en')],
    );

    // return SafeArea(
    //   child: Scaffold(
    //     body: FxText.bodySmall("abc", color: Colors.black,),
    //   ),
    // );
  }
}

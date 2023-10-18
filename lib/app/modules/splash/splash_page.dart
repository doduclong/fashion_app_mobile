import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/login_api.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  final loginApi = LoginApi();
  AnimationController? animationController;
  Animation? animation;

  Future authenticate() async {
    // bool isClient = await Get.put(LoginApi()).readCredentialsFromFile();
    // if (isClient == false) {
    //   //Nếu không thành công đọc được token được lưu sẵn
    //   Get.put(SignInController().retrieveAuthUrl());
    // }
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 0));
    animation = CurvedAnimation(parent: animationController!.view, curve: Curves.linear);
    animationController?.forward().whenComplete(() => Timer(const Duration(seconds: 3), () => authenticate()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: AnimatedBuilder(
            animation: animation!,
            builder: (BuildContext context, Widget? child) {
              return FractionalTranslation(
                translation: Offset(
                  (0),
                  ((Get.height) / 300 - 1) - ((Get.height / 300 - 1.22) * animationController!.value),
                ),
                child: child,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/cmc_logo.png',
                  width: 300,
                  height: 300,
                ),
                // const Text(
                //   "CMC ATI",
                //   style: TextStyle(fontSize: 45, color: Color(0xFF008FD3), fontWeight: FontWeight.bold),
                // )
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }
}

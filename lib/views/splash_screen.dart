import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/themes.dart';
import '../utils/string_constants.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
       Timer(const Duration(seconds: 1), () => Get.offAll(LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryColors,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: Image.asset(ConstantStrings.appBarImageText),
        ),
      ),
    );
  }
}
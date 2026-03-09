import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamplate_getx/modules/splashscreen/controllers/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splashscreen.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

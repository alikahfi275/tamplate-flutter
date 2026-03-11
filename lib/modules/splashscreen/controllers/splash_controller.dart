import 'package:get/get.dart';
import 'package:tamplate_getx/services/auth_service.dart';

class SplashController extends GetxController {
  final AuthService storage = Get.find();

  @override
  void onInit() {
    super.onInit();
    print("SplashController initialized");
  }

  @override
  void onReady() {
    super.onReady();
    checkLogin();
  }

  Future<void> checkLogin() async {
    print("Splash running");

    await Future.delayed(const Duration(seconds: 2));

    final token = await storage.getAccessToken();

    print("Token Ada: $token");

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }
}

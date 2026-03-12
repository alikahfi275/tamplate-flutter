import 'package:get/get.dart';

import 'package:tamplate_getx/services/token_local_service.dart';

class SplashController extends GetxController {
  final localStorage = Get.find<TokenLocalService>();

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  Future<void> checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await localStorage.getToken();
    final accessToken = token?.accessToken ?? '';

    if (accessToken != '' && accessToken.isNotEmpty) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }
}

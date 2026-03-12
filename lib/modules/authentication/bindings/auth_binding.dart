import 'package:get/get.dart';

import 'package:tamplate_getx/modules/authentication/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}

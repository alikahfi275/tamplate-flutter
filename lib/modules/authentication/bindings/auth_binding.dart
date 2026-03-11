import 'package:get/get.dart';
import 'package:tamplate_getx/data/repositories/auth_repository.dart';
import 'package:tamplate_getx/modules/authentication/controllers/auth_controller.dart';
import 'package:tamplate_getx/services/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AuthController(Get.find<AuthRepository>(), Get.find<AuthService>()),
    );
  }
}

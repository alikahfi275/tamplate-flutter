import 'package:get/get.dart';

import 'package:tamplate_getx/modules/authentication/controllers/auth_controller.dart';
import 'package:tamplate_getx/data/repositories/api_repository.dart';
import 'package:tamplate_getx/services/token_local_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthController(
        Get.find<ApiRepository>(),
        Get.find<TokenLocalService>(),
      ),
    );
  }
}

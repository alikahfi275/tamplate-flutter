import 'package:get/get.dart';
import 'package:tamplate_getx/modules/authentication/controllers/auth_controller.dart';
import 'package:tamplate_getx/services/dio_service.dart';
import 'package:tamplate_getx/services/storage_service.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../data/repositories/auth_repository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StorageService());

    Get.put(DioService(Get.find<StorageService>()));

    Get.put(AuthProvider(Get.find<DioService>()));

    Get.put(AuthRepository(Get.find<AuthProvider>()));

    Get.put(
      AuthController(Get.find<AuthRepository>(), Get.find<StorageService>()),
    );
  }
}

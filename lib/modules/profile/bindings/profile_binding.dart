import 'package:get/get.dart';
import 'package:tamplate_getx/data/providers/auth_provider.dart';
import 'package:tamplate_getx/data/repositories/auth_repository.dart';
import 'package:tamplate_getx/modules/profile/controllers/profile_controller.dart';
import 'package:tamplate_getx/services/dio_service.dart';
import 'package:tamplate_getx/services/auth_service.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());

    Get.lazyPut<DioService>(() => DioService(Get.find<AuthService>()));

    Get.lazyPut<AuthProvider>(() => AuthProvider(Get.find<DioService>()));

    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find<AuthProvider>()));

    Get.lazyPut<ProfileController>(
      () => ProfileController(Get.find<AuthRepository>()),
    );
  }
}

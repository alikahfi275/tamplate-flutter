import 'package:get/get.dart';
import 'package:tamplate_getx/services/auth_service.dart';
import 'package:tamplate_getx/services/dio_service.dart';
import 'package:tamplate_getx/data/providers/auth_provider.dart';
import 'package:tamplate_getx/data/repositories/auth_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService(), permanent: true);

    Get.put(DioService(Get.find<AuthService>()), permanent: true);

    Get.put(AuthProvider(Get.find<DioService>()), permanent: true);

    Get.put(AuthRepository(Get.find<AuthProvider>()), permanent: true);
  }
}

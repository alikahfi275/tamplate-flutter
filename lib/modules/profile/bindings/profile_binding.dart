import 'package:get/get.dart';

import 'package:tamplate_getx/services/dio_service.dart';
import 'package:tamplate_getx/services/auth_service.dart';
import 'package:tamplate_getx/data/providers/api_provider.dart';
import 'package:tamplate_getx/data/repositories/api_repository.dart';
import 'package:tamplate_getx/modules/profile/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService());

    Get.lazyPut(() => DioService());

    Get.lazyPut(() => ApiProvider());

    Get.lazyPut(() => ApiRepository());

    Get.lazyPut(() => ProfileController());
  }
}

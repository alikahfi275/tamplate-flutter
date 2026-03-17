import 'package:get/get.dart';

import 'package:tamplate_getx/services/dio_service.dart';
import 'package:tamplate_getx/services/auth_service.dart';
import 'package:tamplate_getx/services/cart_service.dart';
import 'package:tamplate_getx/data/providers/api_provider.dart';
import 'package:tamplate_getx/services/token_local_service.dart';
import 'package:tamplate_getx/services/auth_storage_service.dart';
import 'package:tamplate_getx/data/repositories/api_repository.dart';
import 'package:tamplate_getx/services/xor_encryption_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(XorEncryptionService(), permanent: true);

    Get.put(
      TokenLocalService(Get.find<XorEncryptionService>()),
      permanent: true,
    );

    Get.put(AuthService(), permanent: true);

    Get.put(AuthStorageService(), permanent: true);

    Get.put(DioService(Get.find<TokenLocalService>()), permanent: true);

    Get.put(ApiProvider(Get.find<DioService>()), permanent: true);

    Get.put(ApiRepository(Get.find<ApiProvider>()), permanent: true);

    Get.put(CartService(), permanent: true);
  }
}

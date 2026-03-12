import 'package:get/get.dart';

import 'package:tamplate_getx/core/constants/auth_mapper.dart';
import 'package:tamplate_getx/data/models/user_model.dart';
import 'package:tamplate_getx/data/repositories/api_repository.dart';
import 'package:tamplate_getx/services/isar_service.dart';
import 'package:tamplate_getx/services/token_local_service.dart';

class AuthController extends GetxController {
  final repository = Get.find<ApiRepository>();
  final localStorage = Get.find<TokenLocalService>();

  final isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final tokens = await repository.login(email: email, password: password);

      await localStorage.saveToken(tokens.accessToken, tokens.refreshToken);

      final user = toUserModel(tokens);

      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.userModels.put(user);
      });

      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Error", e.toString());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await localStorage.clearToken();
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.clear();
    });
    Get.offAllNamed('/login');
  }
}

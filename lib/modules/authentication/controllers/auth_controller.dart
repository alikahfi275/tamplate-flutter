import 'package:get/get.dart';
import 'package:tamplate_getx/core/constants/auth_mapper.dart';
import 'package:tamplate_getx/data/models/user_model.dart';
import 'package:tamplate_getx/services/isar_service.dart';
import 'package:tamplate_getx/services/auth_service.dart';

import '../../../data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository = Get.find();
  final AuthService storage = Get.find();

  final isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final tokens = await repository.login(email: email, password: password);

      await storage.saveTokens(tokens.accessToken, tokens.refreshToken);

      final user = toUserModel(tokens);

      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.userModels.put(user);
      });

      Get.offAllNamed('/home');
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await storage.clear();
    await IsarService.isar.writeTxn(() async {
      await IsarService.isar.clear();
    });
    Get.offAllNamed('/login');
  }
}

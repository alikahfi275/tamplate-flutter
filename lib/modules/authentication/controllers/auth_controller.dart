import 'package:get/get.dart';
import 'package:tamplate_getx/services/storage_service.dart';
import '../../../data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  final StorageService storage;

  AuthController(this.repository, this.storage);

  final isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final tokens = await repository.login(email: email, password: password);
      print("LOGIN RESPONSE: $tokens");

      await storage.saveTokens(tokens.accessToken, tokens.refreshToken);

      Get.snackbar("Success", 'Berhasil Login 122312321');
    } catch (e) {
      print("ssLogin error: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await storage.clear();
    Get.offAllNamed('/login');
  }
}

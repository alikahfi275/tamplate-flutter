import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:tamplate_getx/data/models/user_model.dart';
import 'package:tamplate_getx/services/isar_service.dart';
import 'package:tamplate_getx/services/token_local_service.dart';

class HomeController extends GetxController {
  final TokenLocalService localStorage;

  HomeController(this.localStorage);

  final user = Rxn<UserModel>();
  final isLoading = false.obs;
  final accessToken = ''.obs;
  final refreshToken = ''.obs;

  @override
  void onInit() {
    loadUser();
    super.onInit();
  }

  Future<void> loadUser() async {
    try {
      isLoading.value = true;

      final data = await IsarService.isar.userModels.where().findFirst();
      final token = await localStorage.getToken();

      print("data: $data");

      refreshToken.value = token?.refreshToken ?? '';
      accessToken.value = token?.accessToken ?? '';

      user.value = data;
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await localStorage.clearToken();

    Get.offAllNamed('/login');
  }
}

import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:tamplate_getx/data/models/user_model.dart';
import 'package:tamplate_getx/services/isar_service.dart';
import 'package:tamplate_getx/services/auth_service.dart';

class HomeController extends GetxController {
  final AuthService storage = Get.find();

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
      final token = await storage.getAccessToken();
      final refresh = await storage.getRefreshToken();
      refreshToken.value = refresh ?? '';
      accessToken.value = token ?? '';

      user.value = data;
    } catch (e) {
      print("Load user error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

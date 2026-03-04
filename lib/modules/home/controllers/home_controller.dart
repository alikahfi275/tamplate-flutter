import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:tamplate_getx/data/models/user_model.dart';
import 'package:tamplate_getx/services/isar_service.dart';
import 'package:tamplate_getx/services/storage_service.dart';

class HomeController extends GetxController {
  final StorageService storage = Get.find();

  final user = Rxn<UserModel>();
  final isLoading = false.obs;
  final accessToken = ''.obs;

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
      accessToken.value = token ?? '';

      user.value = data;
    } catch (e) {
      print("Load user error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

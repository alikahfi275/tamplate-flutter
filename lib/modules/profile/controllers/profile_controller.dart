import 'package:get/get.dart';
import 'package:tamplate_getx/data/models/user_api_model.dart';
import 'package:tamplate_getx/data/repositories/auth_repository.dart';

class ProfileController extends GetxController with StateMixin<UserApiModel> {
  final AuthRepository repository;

  ProfileController(this.repository);

  Future<void> getProfile() async {
    change(null, status: RxStatus.loading());

    try {
      final user = await repository.getProfile();

      change(user, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}

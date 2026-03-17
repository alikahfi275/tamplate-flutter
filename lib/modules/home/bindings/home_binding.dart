import 'package:get/get.dart';
import 'package:tamplate_getx/services/token_local_service.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(Get.find<TokenLocalService>()));
  }
}

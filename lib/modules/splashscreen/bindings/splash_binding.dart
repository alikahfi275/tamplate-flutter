import 'package:get/get.dart';
import 'package:tamplate_getx/modules/splashscreen/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}

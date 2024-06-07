import 'package:get/get.dart';
import 'auth_service.dart';
import 'auth_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.put(AuthController());
  }
}

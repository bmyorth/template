import 'package:get/get.dart';

import '../../global/global_controller.dart';
import '../../routes/app_routes.dart';

//...

class SplashController extends GetxController {
  // Instancia del controlador global
  GlobalController? ctrlGlobal;

  @override
  Future<void> onInit() async {
    // Instancia del controlador global
    ctrlGlobal = Get.find<GlobalController>();

    super.onInit();
    // ...
  }

  @override
  void onReady() async {
    super.onReady();
    delay(AppPages.overview.name, 3);
  }

  delay(ruta, time) {
    Future.delayed(Duration(seconds: time), () {
      Get.offNamed(ruta);
    });
  }
}

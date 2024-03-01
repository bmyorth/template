import 'dart:io';

import 'package:get/get.dart';

import '../../global/global_controller.dart';
import '../../routes/app_routes.dart';
import '../../services/message/app_message.dart';
import '../../services/providers/user_service.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  // Instancia del controlador global
  GlobalController? ctrlGlobal;

  RxInt counter = 0.obs;

  String title = 'IdooGroup Flutter Template';

  @override
  void onInit() {
    super.onInit();
    // Instancia del controlador global
    ctrlGlobal = Get.find<GlobalController>();
  }

  void incrementCounter() {
    counter.value++;
  }

  /// Salir de la app
  Future<bool> onExitApp() {
    // Pedir confirmación al usuario para salir de la
    // aplicación
    return AppMessage.service.confirm(
      title: ('Confirmation'.tr),
      message: 'Are you sure that you want to close this application?'.tr,
      confirmLabel: 'Yes'.tr,
      cancelLabel: 'No'.tr,
      onConfirm: () async {
        exit(0);
      },
    );
  }

  /// Función que cierra la sessión del usuario autenticado
  logout() async {
    AppMessage.service.presentLoading();
    await UserService().logout();
    AppMessage.service.dismissLoading();
    await Get.offAllNamed(AppPages.login.name);
  }
}

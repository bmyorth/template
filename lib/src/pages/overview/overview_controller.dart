import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ...
import '../../environment/environment.dart';
import '../../routes/app_routes.dart';
import '../../services/system/storage_service.dart';
import 'step/step1.dart';
import 'step/step2.dart';

class OverviewController extends GetxController {
  RxInt currentPage = 0.obs;

  List<Widget> steps = [
    const Step1(),
    const Step2(),
  ];

  @override
  void onInit() {
    super.onInit();
    // ...
  }

  @override
  void onReady() {
    super.onReady();
    // ...
    AppStorage.service.save(Environment.overview, true);
  }

  @override
  void onClose() {
    // ...
    // Ocultar las barra de estado del sistema. La
    // superior e inferior [statusBar & navBar]
    // ...
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.onClose();
    // ...
  }

  goLogin() {
    Get.offNamed(AppPages.login.name);
  }
}

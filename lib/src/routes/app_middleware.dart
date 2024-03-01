import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global/global_controller.dart';
import 'app_routes.dart';

class AppMiddleware extends GetMiddleware {
  final ctrlGlobal = Get.find<GlobalController>();

  @override
  RouteSettings? redirect(String? route) {
    return ctrlGlobal.session.isAuthenticate()
        ? null
        : RouteSettings(name: AppPages.login.name);
  }

  @override
  Widget onPageBuilt(Widget page) {
    debugPrint('Widget ${page.toStringShort()} will be showed');
    return page;
  }

  @override
  void onPageDispose() {
    debugPrint('PageDisposed');
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ...
import '../login_controller.dart';

class LoginVersion extends GetView<LoginController> {
  const LoginVersion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'v${controller.ctrlGlobal?.localVersion.toString()}',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ...
import '../login_controller.dart';

class LoginButtonForgotPass extends GetView<LoginController> {
  const LoginButtonForgotPass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('forgot_pass'.tr,
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14.0,
              color: Colors.black)),
      onPressed: () {
        // Ocultar el teclado
        FocusScope.of(context).unfocus();
        controller.onForgotPass();
      },
    );
  }
}

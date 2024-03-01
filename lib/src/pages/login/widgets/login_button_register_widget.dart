import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ...
import '../login_controller.dart';

class LoginButtonRegister extends GetView<LoginController> {
  const LoginButtonRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('register'.tr.toUpperCase(),
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14.0,
              color: Colors.black)),
      onPressed: () {
        // Ocultar el teclado
        FocusScope.of(context).unfocus();
        controller.onRegister();
      },
    );
  }
}

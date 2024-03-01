import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ...
import '../../../global/widgets/button_app_widget.dart';
import '../../../types/app_types.dart';
import '../login_controller.dart';

class LoginBottonAuth extends GetView<LoginController> {
  const LoginBottonAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonApp(
      text: 'enter'.tr.toUpperCase(),
      type: BUTTONTYPE.PRIMARY,
      onPress: () {
        // Ocultar el teclado
        // FocusScope.of(context).unfocus();
        controller.buttonLoginPress(context);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ...
import '../../../global/widgets/input_text_widget.dart';
import '../../../themes/colors_theme.dart';
import '../login_controller.dart';

class LoginInputPassword extends GetView<LoginController> {
  const LoginInputPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ...
    return Obx(
      () => InputText(
        controller: controller.password,
        obscureText: controller.obscure.value,
        type: TextInputType.text,
        textInputAction: TextInputAction.done,
        validate: (String value) {
          if (GetUtils.isNullOrBlank(value)!) {
            return 'field_required'.tr;
          } else if (value.length < 8) {
            return 'field_least_8'.tr;
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: 'password'.tr,
          prefixIcon: const Icon(
            Icons.key_sharp,
            color: AppColors.secondary,
            size: 25.0,
          ),
          suffixIcon: controller.showPass.value
              ? IconButton(
                  splashRadius: 10.0,
                  // padding: EdgeInsets.all(1),
                  icon: Icon(
                    controller.obscure.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.black87,
                    size: 20.0,
                  ),

                  onPressed: () {
                    controller.obscure.value = !controller.obscure.value;
                  },
                )
              : Container(),
        ),
      ),
    );
  }
}

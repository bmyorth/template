import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ...
import '../../../themes/colors_theme.dart';
import '../login_controller.dart';

class LoginCheckBox extends GetView<LoginController> {
  const LoginCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    // ...
    return Obx(
      () => SizedBox(
        height: 50.0,
        child: SwitchListTile(
          value: controller.remember.value,
          onChanged: (newValue) => controller.remember.value = newValue,
          title: Text(
            'remember'.tr,
            style: TextStyle(
              fontSize: 14,
              fontWeight:
                  controller.remember.value ? FontWeight.w600 : FontWeight.w500,
              color: AppColors.textColorDark,
            ),
          ),
        ),
      ),
    );
  }
}

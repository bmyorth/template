import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ...

import '../../../global/widgets/input_text_widget.dart';
import '../../../themes/colors_theme.dart';
import '../login_controller.dart';

class LoginInputEmail extends GetView<LoginController> {
  const LoginInputEmail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ...
    return InputText(
        controller: controller.email,
        type: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        validate: (String value) {
          if (GetUtils.isNullOrBlank(value)!) {
            return 'field_required'.tr;
          }
          // else if (!GetUtils.isEmail(value)) {
          //   return 'The field must be a valid email'.tr;
          // }
          else {
            return null;
          }
        },
        textInputAction: TextInputAction.next,
        // style: AppStyles.inputsTextStyle,
        decoration: InputDecoration(
          hintText: 'email'.tr,
          prefixIcon: const Icon(
            Icons.email,
            color: AppColors.secondary,
            size: 25.0,
          ),
        ));

    // decoration: AppStyles.inputTextDefaultDecorator
    //     .copyWith(hintText: 'E-mail'.tr));
  }
}

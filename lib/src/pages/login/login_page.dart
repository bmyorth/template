import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/system/screen_service.dart';
import 'login_controller.dart';
import 'widgets/login_button_auth_page.dart';
import 'widgets/login_button_forgot_pass_widget.dart';
import 'widgets/login_button_register_widget.dart';
import 'widgets/login_checkbox_widget.dart';
import 'widgets/login_input_email_widget.dart';
import 'widgets/login_input_password_widget.dart';
import 'widgets/login_logotipo_widget.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});
  // ...
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: LoginInterface()),
    );
  }
}

class LoginInterface extends GetView<LoginController> {
  const LoginInterface({super.key});

  @override
  Widget build(BuildContext context) {
    AppScreen screen = AppScreen(context);
    return Obx(
      () => Form(
        key: controller.formKey,
        autovalidateMode: controller.autovalidate.value
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.only(
                  left: screen.widthPercent(8.0),
                  right: screen.widthPercent(8.0),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //...
                    LoginLogotipo(),
                    // ...
                    LoginInputEmail(),
                    // ...
                    LoginInputPassword(),
                    // ...
                    LoginCheckBox(),
                    //..
                    LoginBottonAuth(),
                    //..
                    LoginButtonForgotPass(),
                    //..
                    LoginButtonRegister(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

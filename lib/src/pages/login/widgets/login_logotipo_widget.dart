import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginLogotipo extends StatelessWidget {
  const LoginLogotipo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/idoogroup.png',
          width: 150.0,
        ),
        Text(
          'app_title'.tr.toUpperCase(),
          style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

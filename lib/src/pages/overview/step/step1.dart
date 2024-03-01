import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Step1 extends StatelessWidget {
  const Step1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'wellcome'.tr} ${'to'.tr} ${'app_title'.tr}',
                style: const TextStyle(
                    fontSize: 34.0, fontWeight: FontWeight.w500),
              ),
              Text(
                'overview_step1_slogan'.tr,
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../../../services/system/screen_service.dart';

class Step2 extends StatelessWidget {
  const Step2({super.key});

  @override
  Widget build(BuildContext context) {
    final size = AppScreen(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: -50.0,
          left: 100.0,
          child: Transform.rotate(
            angle: 20 * math.pi / 180,
            child: SizedBox.square(
              dimension: size.heightPercent(50.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: const Color.fromARGB(31, 130, 126, 164),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -100.0,
          left: -80.0,
          child: Transform.rotate(
            angle: 320 * math.pi / 180,
            child: SizedBox.square(
              dimension: size.heightPercent(50.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: const Color.fromARGB(31, 130, 126, 164),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'overview_step2_title'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 34.0, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'overview_step2_slogan1'.tr,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'overview_step2_slogan2'.tr,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              //-----------------------------------------------------
              const SizedBox(
                height: 50.0,
              ),
              Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/idoogroup.png',
                        fit: BoxFit.cover,
                        height: size.heightPercent(20.0),
                      ),
                      const Text(
                        'Apps',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

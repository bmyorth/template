import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ...
import '../../services/system/screen_service.dart';
import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeIn(
        delay: const Duration(seconds: 1),
        duration: const Duration(seconds: 2),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: AppScreen(context).widthPercent(40.0),
                child: const Image(
                  image: AssetImage(
                    'assets/images/idoogroup.png',
                  ),
                ),
              ),

              //-----------------------------------------
              Text(
                'app_title'.tr.toUpperCase(),
                style: const TextStyle(
                    fontSize: 28.0, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

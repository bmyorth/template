import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ...

import '../../themes/colors_theme.dart';
import 'overview_controller.dart';
import 'widgets/overview_slide_dots_page.dart';

class OverviewPage extends GetView<OverviewController> {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            PageView.builder(
              itemBuilder: (context, index) {
                return controller.steps[index];
              },
              itemCount: controller.steps.length,
              onPageChanged: (value) {
                controller.currentPage.value = value;
              },
            ),
            controller.currentPage.value == controller.steps.length - 1
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: ElevatedButton(
                      child: Text(
                        'skip'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      onPressed: () {
                        controller.goLogin();
                      },
                    ),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
              child: OverviewSlideDots(
                length: controller.steps.length,
                currentPage: controller.currentPage.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:get/get.dart';

// ...
import 'overview_controller.dart';

class OverviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OverviewController());
  }
}

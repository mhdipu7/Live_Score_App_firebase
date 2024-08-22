import 'package:get/get.dart';
import 'package:live_football_score/controller/home_screen_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController(), fenix: true);
  }
}

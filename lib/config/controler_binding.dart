import 'package:get/get.dart';
import 'package:schedule_app/states/schedule.dart';

class InitialControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleController>(() => ScheduleController()..loadState(),
        fenix: true);
  }
}

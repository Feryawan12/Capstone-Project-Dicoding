import 'package:get/get.dart';
import 'package:schedule_app/models/schedule.dart';
import 'package:schedule_app/services/firestore/schedule.dart';

class ScheduleState {}

class InitSchedule extends ScheduleState {}

class FilledSchedule extends ScheduleState {
  final bool isFull;
  final Iterable<ScheduleModel>? data;

  FilledSchedule({this.isFull = false, this.data});
}

class ScheduleController extends GetxController {
  static ScheduleController get to => Get.find();

  ScheduleState state = InitSchedule();

  void loadState() async {
    if (state is InitSchedule) {
      state = FilledSchedule(data: await ScheduleStore.read());
      update();
    }
  }

  void resetState() {
    if (state is FilledSchedule) {
      state = InitSchedule();
      update();
    }
  }
}

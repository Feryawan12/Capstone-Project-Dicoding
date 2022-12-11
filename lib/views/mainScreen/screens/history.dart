import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app/views/schedule/add_schedule.dart';
import 'package:schedule_app/views/globalWidgets/progress_indicator.dart';
import 'package:schedule_app/views/mainScreen/widgets/event_list.dart';
import '../../../states/schedule.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Daftar Schedule',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
            child: GetBuilder<ScheduleController>(
                global: true,
                builder: (snapshot) {
                  return snapshot.state is FilledSchedule
                      ? EventList(
                          showFrom: 1,
                          data:
                              (snapshot.state as FilledSchedule).data!.toList())
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 60),
                          child: ProgressDefaultIndicator(),
                        );
                })),
        floatingActionButton: InkWell(
          onTap: () => Get.to(() => const AddSchedule(
                fromScreen: 1,
              )),
          borderRadius: BorderRadius.circular(60),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: 30,
            child: const Icon(
              Icons.add,
              size: 35,
              color: Colors.white,
            ),
          ),
        ));
  }
}

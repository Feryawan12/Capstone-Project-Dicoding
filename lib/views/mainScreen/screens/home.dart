import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app/states/schedule.dart';
import 'package:schedule_app/views/schedule/add_schedule.dart';
import 'package:schedule_app/views/globalWidgets/account_card.dart';
import 'package:schedule_app/views/globalWidgets/progress_indicator.dart';
import 'package:schedule_app/views/mainScreen/widgets/calendar_event.dart';
import 'package:schedule_app/views/mainScreen/widgets/event_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.only(top: 12.0),
      child: GetBuilder<ScheduleController>(didChangeDependencies: (state) {
        state.controller!.loadState();
      }, builder: (snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AccountCard(),
            const SizedBox(
              height: 17.0,
            ),
            Text(
              'Calendar',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: 13.0,
            ),
            snapshot.state is FilledSchedule
                ? CalendarEvent(
                    eventList:
                        (snapshot.state as FilledSchedule).data!.toList(),
                  )
                : const ProgressDefaultIndicator(),
            const SizedBox(
              height: 17.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Daftar Schedule',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                ElevatedButton(
                    onPressed: () => Get.to(() => const AddSchedule(
                          fromScreen: 0,
                        )),
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: const Text('Buat Tugas'))
              ],
            ),
            const SizedBox(
              height: 13.0,
            ),
            snapshot.state is FilledSchedule
                ? EventList(
                    showFrom: 0,
                    data: (snapshot.state as FilledSchedule).data!.toList())
                : const Padding(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    child: ProgressDefaultIndicator(),
                  )
          ],
        );
      }),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app/views/globalWidgets/account_card.dart';

import '../../../states/schedule.dart';
import '../../globalWidgets/progress_indicator.dart';
import '../widgets/event_list.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 17.0,
            ),
            const AccountCard(),
            const SizedBox(
              height: 17.0,
            ),
            Text(
              'Daftar Schedule',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: 13.0,
            ),
            GetBuilder<ScheduleController>(builder: (snapshot) {
              if (snapshot.state is FilledSchedule) {
                return EventList(
                    showFrom: 2,
                    data: (snapshot.state as FilledSchedule).data!.toList());
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: ProgressDefaultIndicator(),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

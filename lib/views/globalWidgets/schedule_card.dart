import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app/config/theme.dart';
import 'package:schedule_app/models/schedule.dart';
import 'package:schedule_app/views/schedule/edit_schedule.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleModel schedule;
  final int fromScreen;
  const ScheduleCard({super.key, this.fromScreen = 0, required this.schedule});

  Chip _statusSchip(int status) {
    if (status == 0) {
      return Chip(
          label: const Text('Tertunda', softWrap: true),
          elevation: 0,
          backgroundColor: Colors.orange[600],
          labelStyle:
              ThemeApp.textStyleTheme(size: 11.0, isHead: true, isLight: true));
    } else if (status == 1) {
      return Chip(
          label: const Text('Selesai', softWrap: true),
          elevation: 0,
          backgroundColor: Colors.green[600],
          labelStyle:
              ThemeApp.textStyleTheme(size: 11.0, isHead: true, isLight: true));
    }

    return Chip(
        label: const Text('Terlewat', softWrap: true),
        elevation: 0,
        backgroundColor: Colors.red,
        labelStyle:
            ThemeApp.textStyleTheme(size: 11.0, isHead: true, isLight: true));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: ListTile(
          contentPadding: const EdgeInsets.all(8.6),
          onTap: () {
            if (DateTime.now()
                .difference(DateTime.parse(schedule.date!))
                .isNegative) {
              Get.to(() => EditSchedule(
                    schedule: schedule,
                    fromScreen: fromScreen,
                  ));
            } else {
              Get.defaultDialog(
                  title: 'Tidak bisa dibuka!',
                  content: Text(
                    'Karena sudah melewati tanggal ${schedule.date!.split(' ').first}, jam ${schedule.date!.split(' ').last}',
                    textAlign: TextAlign.center,
                  ),
                  confirm: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: const Text('OK')));
            }
          },
          title: Text(schedule.name!,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: Theme.of(context).primaryTextTheme.displayMedium),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.date_range, color: Colors.white, size: 19),
                  Text(' ${schedule.date} ${schedule.time}',
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).primaryTextTheme.displaySmall),
                ],
              ),
              const SizedBox(height: 5.0),
              Text('Label: ${schedule.kategoriRef!.name}',
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: ThemeApp.textStyleTheme(
                      color: Colors.white, isHead: true, size: 11)),
            ],
          ),
          trailing: _statusSchip(!DateTime.now()
                      .difference(DateTime.parse(schedule.date!))
                      .isNegative &&
                  schedule.status != 1
              ? 3
              : schedule.status!)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:schedule_app/models/schedule.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarEvent extends StatefulWidget {
  final List<ScheduleModel>? eventList;
  const CalendarEvent({super.key, this.eventList});

  @override
  State<CalendarEvent> createState() => _CalendarEventState();
}

class _CalendarEventState extends State<CalendarEvent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14), color: Colors.white),
      child: TableCalendar(
        eventLoader: (day) {
          if (widget.eventList!
              .where(
                  (element) => element.date == day.toString().split(' ').first)
              .isNotEmpty) {
            final List<ScheduleModel> tgl = widget.eventList!
                .where((element) =>
                    element.date == day.toString().split(' ').first)
                .toList();
            return tgl.map((e) => e.date).toList();
          }

          return [];
        },
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(1999),
        lastDay: DateTime.utc(2100),
      ),
    );
  }
}

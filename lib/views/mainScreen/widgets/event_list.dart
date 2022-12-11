import 'package:flutter/material.dart';
import 'package:schedule_app/models/schedule.dart';
import 'package:schedule_app/views/globalWidgets/schedule_card.dart';

class EventList extends StatefulWidget {
  final List<ScheduleModel> data;
  final int showFrom;
  const EventList({super.key, this.showFrom = 0, required this.data});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ScheduleCard(
                schedule: widget.data[index], fromScreen: widget.showFrom),
          );
        });
  }
}

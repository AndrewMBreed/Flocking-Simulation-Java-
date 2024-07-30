import 'package:flutter/material.dart';
import 'package:cal_app/models/event.dart';
import 'package:cal_app/widgets/eventBox.dart';

class EventDisplay extends StatelessWidget {
  final Event event;

  EventDisplay({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueGrey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Expanded(child: eventBox(event)),
    );
  }
}
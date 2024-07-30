import 'package:flutter/material.dart';
import 'package:cal_app/models/task.dart';
import 'package:cal_app/widgets/checkbox.dart';
import 'package:cal_app/widgets/onTap.dart';

class TaskDisplay extends StatelessWidget {
  final Task task;

  TaskDisplay({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(

        color: (task.completed == 0) ?
        Colors.blueGrey[200]:
        Colors.indigo,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: onTap(task)),
          checkboxWidget(task),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cal_app/models/task.dart';
import 'package:cal_app/screens/taskPage.dart';
import 'package:cal_app/themes/theme.dart';

class onTap extends StatefulWidget {
  final Task? task;

  const onTap(this.task);

  @override
  State<onTap> createState() => _onTap();

}

class _onTap extends State<onTap> {
  late Task task;
  late int? id;
  late String name;
  late String description;
  late int repeatDelay;
  late DateTime dueDate;
  late int completed;

  @override
  void initState(){
    super.initState();
    name = widget.task?.name ?? '';
    id = widget.task?.id;
    description = widget.task?.description ?? '';
    repeatDelay = widget.task?.repeatDelay ?? 0;
    completed = widget.task?.completed ?? 0;
    dueDate = widget.task?.dueDate ?? DateTime.now();
    task = Task(id: id, repeatDelay: repeatDelay, dueDate: dueDate, name: name, description: description, completed: completed);
  }

  void submit() {
    TaskPage.task = task;
    TaskPage.update = 1;

  }

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {submit();},
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 5,
              ),
            ),
            description != '' ?
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
                :
            Padding(
              padding: EdgeInsets.only(
                top: 1,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                top: 5,
              ),
              child: Text(
                dueDate.difference(DateTime.now()).inHours <= 0 ? "Due Today" :
                (dueDate.difference(DateTime.now()).inHours <= 24 ? "Due in 1 day" :
                "Due in " + (dueDate.difference(DateTime.now()).inDays + 1).toString() + " days"),
                //+ task.dueDate.toIso8601String() ?? "Task due date not found.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[900],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
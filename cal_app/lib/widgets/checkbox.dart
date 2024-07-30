import 'package:flutter/material.dart';
import 'package:cal_app/models/task.dart';
import 'package:cal_app/database/database.dart';
import 'package:cal_app/screens/taskPage.dart';

class checkboxWidget extends StatefulWidget {
  final Task? task;

  const checkboxWidget(this.task);

  @override
  State<checkboxWidget> createState() => _checkboxWidget();

}

class _checkboxWidget extends State<checkboxWidget> {
  late int? id;
  late String name;
  late String description;
  late int repeatDelay;
  late DateTime dueDate;
  late bool isChecked;



  @override
  void initState(){
    super.initState();
    name = widget.task?.name ?? '';
    id = widget.task?.id;
    description = widget.task?.description ?? '';
    repeatDelay = widget.task?.repeatDelay ?? 0;
    dueDate = widget.task?.dueDate ?? DateTime.now();
    if(widget.task?.completed == 0){
      isChecked = false;
    }else{
      isChecked = true;
    }
    }

  Future submit() async{
    if(isChecked == true) {
      Task task = Task(id: id, name: name, description: description, completed: 1, repeatDelay: repeatDelay, dueDate: dueDate);
      await mainDatabase.instance.updateTask(task);
    }else{
      Task task = Task(id: id, name: name, description: description, completed: 0, repeatDelay: repeatDelay, dueDate: dueDate);
      await mainDatabase.instance.updateTask(task);
    }
    TaskPage.checkbox = true;
  }


  @override
  Widget build(BuildContext context){
    return Checkbox(
        value: isChecked,
        onChanged: (bool? value){
          isChecked = value!;
          submit();
          });
  }
}
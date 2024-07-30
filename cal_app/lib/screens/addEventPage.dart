import 'package:flutter/material.dart';
import 'package:cal_app/models/task.dart';
import 'package:cal_app/database/database.dart';
import 'package:cal_app/widgets/taskForm.dart';
import 'package:cal_app/themes/theme.dart';


class AddTaskPage extends StatefulWidget {

  final Task? task;

  const AddTaskPage([this.task]);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late int? id;
  late String name;
  late String description;
  late int repeatDelay;
  late int completed;
  late DateTime dueDate;
  late bool oldTask;

  @override
  void initState(){
    super.initState();
    if(widget.task?.name != null){
      oldTask = true;
    }else{
      oldTask = false;
    }
    id = widget.task?.id;
    name = widget.task?.name ?? '';
    description = widget.task?.description ?? '';
    repeatDelay = widget.task?.repeatDelay ?? 0;
    dueDate = widget.task?.dueDate ?? DateTime.now();
    completed = widget.task?.completed ?? 0;
  }

  Future submitTask() async{
    if(name != ''){
      if(oldTask == false){
        Task task = Task(name: name, description: description,completed: completed, repeatDelay: repeatDelay, dueDate: dueDate);
        await mainDatabase.instance.createTask(task);
      }else{
        Task task = Task(id: id, name: name, description: description,completed: completed, repeatDelay: repeatDelay, dueDate: dueDate);
        await mainDatabase.instance.updateTask(task);
      }
      Navigator.pop(context);
    }
  }

  Future deleteTask() async{
    await mainDatabase.instance.deleteTask(id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.primaryColor,
        appBar: AppBar(
          title: Text(oldTask ? "Update Task" : "Add Task", style: TextStyle(color: theme.textColor)),
          backgroundColor: theme.secondaryColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: TaskForm(
                      name: name,
                      description: description,
                      repeatDelay: repeatDelay,
                      dueDate: dueDate,

                      onChangedName: (name) => setState(() => this.name = name),
                      onChangedDescription: (description) => setState(() => this.description = description),
                      onChangedDueDate: (dueDate) => setState(() => this.dueDate = DateTime.parse(dueDate)),
                      onChangedRepeatDelay: (repeatDelay) => setState(() => this.repeatDelay = int.parse(repeatDelay!)),
                      //on changed
                    )
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      oldTask ? Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: theme.denyColor,
                              ),
                              onPressed: () {
                                deleteTask();
                              },
                              child:
                              Text("Delete Task"),
                            ),
                            Padding( padding: EdgeInsets.all(10)),
                          ]
                      ) : Padding( padding: EdgeInsets.all(0)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: theme.acceptColor,
                        ),
                        onPressed: () {
                          submitTask();
                        },
                        child:
                        Text(oldTask ? "Update Task" : "Add Task"),
                      ),
                    ]
                ),
              ]
          ),
        )
    );
  }
}
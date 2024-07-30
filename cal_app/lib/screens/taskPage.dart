import 'package:flutter/material.dart';
import 'package:cal_app/displays/taskDisplay.dart';
import 'package:cal_app/models/task.dart';
import 'package:cal_app/database/database.dart';
import 'package:cal_app/screens/addTaskPage.dart';
import 'package:cal_app/themes/theme.dart';


class TaskPage extends StatefulWidget {
  static int update = 0;
  static Task task = Task(id: 0, name: '',completed: 0, description: '', repeatDelay: 0, dueDate: DateTime.now());
  static bool loading = true;
  static bool checkbox = false;

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<TaskPage> {

  late List<Task> tasks;

  @override
  void initState() {
    TaskPage.loading = true;
    updateTasks();
    super.initState();
  }

  @override
  void destroy() {
    mainDatabase.instance.close();
    super.dispose();
  }

  Future updateTasks() async {

    if(TaskPage.checkbox == true){
      this.tasks = await mainDatabase.instance.readAllTasks();
      setState(() {});
      TaskPage.checkbox = false;
    }

    if(TaskPage.loading == true) {

      this.tasks = await mainDatabase.instance.readAllTasks();
      if(TaskPage.checkbox == true){
        setState(() {});
        TaskPage.checkbox = false;
      }
      for (int i = 0; i < tasks.length; i++) {
        if (tasks[i].dueDate.difference(DateTime.now()).inDays < 0) {
          if (tasks[i].repeatDelay > 0) {
            Task newTask = Task(id: tasks[i].id,
                name: tasks[i].name,
                completed: 0,
                description: tasks[i].description,
                repeatDelay: tasks[i].repeatDelay,
                dueDate: (tasks[i].dueDate.add(new Duration(days: tasks[i].repeatDelay))));
            mainDatabase.instance.updateTask(newTask);
          } else {
            mainDatabase.instance.deleteTask(tasks[i].id!);
          }
        }
      }
      this.tasks = await mainDatabase.instance.readAllTasks();

    }
    await Future.delayed(Duration(milliseconds: 5));
    updateTaskPage();
    setState(() {});
    if(TaskPage.update == 0) {
      TaskPage.loading = false;
      setState(() {});
    }
  }

  Future newTaskPage() async {
    await Navigator.pushNamed(context, '/addTaskPage');
    TaskPage.loading = true;
    updateTasks();
    setState(() {});
  }

  Future updateTaskPage() async {
    Future<int> checkUpdate() {
      return Future<int>.value(TaskPage.update);
    }
    await checkUpdate();
    if(TaskPage.update == 1) {
      TaskPage.update = 2;
      TaskPage.loading = true;
      await Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskPage(TaskPage.task)));
      setState(() {});
      TaskPage.update = 0;
    }
    updateTasks();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        title: Text("Tasks", style: TextStyle(color: theme.textColor)),
        backgroundColor: theme.secondaryColor,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: TaskPage.loading ? CircularProgressIndicator(color: theme.secondaryColor,) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          tasks.isEmpty ? Text(
          'No Tasks',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: theme.textColor,
              fontWeight: FontWeight.bold,
            ),
          ):
          Expanded(
          child:
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
              itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.only(
                bottom: 10,
              ),
              child: TaskDisplay(task: tasks[index]),
            );
          }
      )

      ),


          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: theme.acceptColor,
            ),
            onPressed: () {
              newTaskPage();
            },
            child: Text("Add Task", style: TextStyle(color: theme.textColor)),
          ),
        ],
      )
    )
    );
}}
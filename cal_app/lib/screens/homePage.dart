import 'package:flutter/material.dart';
import 'package:cal_app/themes/theme.dart';
import 'package:cal_app/models/event.dart';
import 'package:cal_app/database/database.dart';
import 'package:intl/intl.dart';
import 'package:cal_app/models/task.dart';
import 'package:cal_app/Displays/eventDisplay.dart';

class HomePage extends StatefulWidget {
  static bool loading = true;
  static int tasksToDo = 0;
  static int totalTasks = 0;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {

  late List<Event> allEvents;
  late List<Event> todaysEvents;
  late List<Task> tasks;
  late DateTime time;
  
  @override
  void initState() {
    theme.setTheme(themeOptions().dark);
    update();
    super.initState();
  }
  
  Future update() async{
    time = DateTime.now();
    todaysEvents = [];
    if(HomePage.loading)
    {
    HomePage.tasksToDo = 0;
    HomePage.totalTasks = 0;
    this.tasks = await mainDatabase.instance.readAllTasks();
    for(int i = 0; i < tasks.length; i++) {

      if(tasks[i].dueDate.difference(DateTime.now()).inHours <= 0){
        HomePage.totalTasks++;
        if(tasks[i].completed == 0){
          HomePage.tasksToDo++;
        }
      }
    }
    this.allEvents = await mainDatabase.instance.readAllEvents();
    for(int i = 0; i < allEvents.length; i++){
      if(allEvents[i].dueDate.day == time.day){
        todaysEvents.add(allEvents[i]);
      }
    }
    HomePage.loading = false;
    setState(() {});
    }

  }

  Future taskPage() async {
    HomePage.loading = true;
    await Navigator.pushNamed(context, '/taskPage');
    update();
  }


  Future calendarPage() async {
    HomePage.loading = true;
    await Navigator.pushNamed(context, '/calendarPage');
    update();
  }

  Future settingsPage() async {
    HomePage.loading = true;
    await Navigator.pushNamed(context, '/settingsPage');
    update();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: theme.primaryColor,
        appBar: AppBar(
          title: Text(DateFormat('EEEEEEEEE dd MMMM').format(time)),
          backgroundColor: theme.secondaryColor,
          actions: [
            ElevatedButton(
              onPressed: (){settingsPage();},
              style: ElevatedButton.styleFrom(
                primary: theme.secondaryColor,
              ),
              child: Icon(
                  Icons.settings,
                  color: theme.textButtonColor
              )
            )
          ],
        ),
        body: Container(
            margin: EdgeInsets.all(10),
            child: HomePage.loading ? CircularProgressIndicator(color: theme.secondaryColor,) :
           Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child:
                  todaysEvents.length != 0 ?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: todaysEvents.length,
                        itemBuilder: (BuildContext context, int index){
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: EventDisplay(event: todaysEvents[index]),
                          );
                        }
                    )
                    :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Padding(padding: EdgeInsets.only(bottom: 5))),
                        Text("No Events Today",
                        style: TextStyle(
                            color: theme.textColor,
                            fontSize: 30
                        ),
                        ),
                        Expanded(child: Padding(padding: EdgeInsets.only(bottom: 5))),
                      ],
                  ),

              ),
              Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                  )
              ),
              //add scroll list --------------------------------------------------------------------------------

              Padding(
                  padding: EdgeInsets.only(
                    bottom: 5,
                  )
              ),

                ElevatedButton(
                    onPressed: () {
                      calendarPage();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: theme.acceptColor,
                    ),
                    child: Text("Calendar",
                        style: TextStyle(
                        color: theme.textButtonColor
                    ),)
                ),
                Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                    )
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Daily Tasks Completed: " + (HomePage.totalTasks - HomePage.tasksToDo).toString() + " / " + HomePage.totalTasks.toString(),
                    style: TextStyle(
                        color: theme.textColor,
                        fontSize: 20
                    ),
                  ),],
                ),

                Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                    )
                ),


                ElevatedButton(
                    onPressed: () {
                      taskPage();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: theme.acceptColor,
                    ),
                    child: Text("Task List",
                      style: TextStyle(
                        color: theme.textButtonColor
                    ),)
                ),
            ],
          )
        ),
      
   );
  }
}

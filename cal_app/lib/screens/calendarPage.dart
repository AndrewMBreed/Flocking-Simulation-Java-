import 'package:flutter/material.dart';
import 'package:cal_app/widgets/calendar.dart';
import 'package:cal_app/database/database.dart';
import 'package:cal_app/screens/addEventPage.dart';
import 'package:cal_app/themes/theme.dart';
import 'package:cal_app/models/event.dart';


class CalendarPage extends StatefulWidget {
  static int update = 0;
  static Event event = Event(id: 0, name: '', description: '',dueDate: DateTime.now(), duration: 0, repeatFrequency: 0);
  static bool loading = true;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<CalendarPage> {
  late List<Event> events;

  @override
  void initState() {

    updateEvents();
    super.initState();
  }

  @override
  void destroy() {
    mainDatabase.instance.close();
    super.dispose();
  }

  Future updateEvents() async {
    this.events = await mainDatabase.instance.readAllEvents();
    CalendarPage.loading = false;

  }

  Future newTaskPage() async {
    CalendarPage.loading = true;
    await Navigator.pushNamed(context, '/addTaskPage');
    updateEvents();
    setState(() {});
  }

  Future updateEventPage() async {
    Future<int> checkUpdate() {
      return Future<int>.value(CalendarPage.update);
    }
    await checkUpdate();
    if(CalendarPage.update == 1) {
      CalendarPage.update = 2;
      CalendarPage.loading = true;
      //await Navigator.push(context, MaterialPageRoute(builder: (context) => AddEventPage(CalendarPage.event)));
      setState(() {});
      CalendarPage.update = 0;
      updateEvents();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: theme.primaryColor,
            appBar: AppBar(
              title: Text("Calendar", style: TextStyle(color: theme.textColor)),
              backgroundColor: theme.secondaryColor,
            ),
            body: Container(
                margin: EdgeInsets.all(10),
                child:
                CalendarPage.loading ? CircularProgressIndicator()
                    :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    events.isEmpty ? Text(
                      'No Tasks',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: theme.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ):
                    Calendar(),


                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: theme.acceptColor,
                      ),
                      onPressed: () {
                        newTaskPage();
                      },
                      child: Text("Add Event", style: TextStyle(color: theme.textColor)),
                    ),
                  ],
                )
            )
    );
  }
}
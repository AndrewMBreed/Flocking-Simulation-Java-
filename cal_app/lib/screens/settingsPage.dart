import 'package:flutter/material.dart';
import 'package:cal_app/themes/theme.dart';

class SettingsPage extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  late DateTime time;

  @override
  void initState() {
    theme.setTheme(themeOptions().dark);
    super.initState();
  }

  Future setTime() async{
    time = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[300],
        appBar: AppBar(
          title: Text("Schedule"),
          backgroundColor: Colors.blueGrey[800],
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 60.0),





          /*
          padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 60.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.values,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[


              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/calendarPage');
                  },
                  child: Text("Calendar")
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/taskPage');
                  },
                  child: Text("Task List")
              ),
            ],
          ),
          */
        ),

      );
  }
}

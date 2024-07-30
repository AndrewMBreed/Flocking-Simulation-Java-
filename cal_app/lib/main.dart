import 'package:flutter/material.dart';
import 'package:cal_app/screens/homePage.dart';
import 'package:cal_app/screens/calendarPage.dart';
import 'package:cal_app/screens/taskPage.dart';
import 'package:cal_app/screens/addTaskPage.dart';
import 'package:cal_app/screens/settingsPage.dart';



void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/calendarPage': (context) => CalendarPage(),
          '/taskPage': (context) => TaskPage(),
          '/addTaskPage': (context) => AddTaskPage(),
          '/settingsPage': (context) => SettingsPage(),
        },
      )
  );
}
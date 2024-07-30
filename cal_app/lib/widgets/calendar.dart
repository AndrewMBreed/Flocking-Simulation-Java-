import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[300],
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: TableCalendar(
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2040, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.monday,
        selectedDayPredicate: (day){
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay){
          if(!isSameDay(_selectedDay, focusedDay)){
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
      ),
    );
  }
}
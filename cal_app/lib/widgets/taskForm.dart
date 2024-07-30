import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

final DateTime now = DateTime.now();
DateTime? startValue = now.subtract(Duration(hours: now.hour,minutes: now.minute));

class TaskForm extends StatelessWidget{
  final String? name;
  final String? description;
  final int? repeatDelay;
  final DateTime? dueDate;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String?>? onChangedRepeatDelay;
  final ValueChanged<String> onChangedDueDate;
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(child: Text("Never"),value: "0"),
      DropdownMenuItem(child: Text("Daily"),value: "1"),
      DropdownMenuItem(child: Text("Alternate Days"),value: "2"),
      DropdownMenuItem(child: Text("Weekly"),value: "7"),
      DropdownMenuItem(child: Text("Bi-Weekly"),value: "14"),
    ];
    return items;
  }

  const TaskForm({
    Key? key,
    this.name = '',
    this.description = '',
    this.repeatDelay = 0,
    this.dueDate,
    required this.onChangedName,
    required this.onChangedDescription,
    required this.onChangedRepeatDelay,
    required this.onChangedDueDate
  }) : super(key: key);

  Future updateDate() async{
    if(dueDate != null){
      startValue = dueDate;
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      Padding(
      padding: EdgeInsets.only(
          bottom: 16
        ),
      ),
      TextFormField(
        style: TextStyle(fontSize: 16),
        initialValue: name,
        decoration: InputDecoration(
            labelText: "Task Name",
            labelStyle: TextStyle(fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            )),
        validator: (input) =>
        input != null && input.isEmpty ? "Please enter a task name" : null,
        onChanged: onChangedName,
      ),
      Padding(
        padding: EdgeInsets.only(
            bottom: 16
        ),
      ),
      TextFormField(
        style: TextStyle(fontSize: 16),
        initialValue: description,
        decoration: InputDecoration(
            labelText: "Task Description",
            labelStyle: TextStyle(fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            )),
        onChanged: onChangedDescription,
      ),
      Padding(
        padding: EdgeInsets.only(
          bottom: 16
        ),
      ),
      //__________________________________________________________________________________________
      DropdownButton(
        items: dropdownItems,
        value: repeatDelay.toString(),
        onChanged: onChangedRepeatDelay,
      ),
      Padding(
        padding: EdgeInsets.only(
          bottom: 16
        ),
      ),
      DateTimePicker(
          initialValue: dueDate != null ? dueDate!.toIso8601String() : startValue!.toIso8601String(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          dateLabelText: 'Date',
          onChanged: onChangedDueDate,
          validator: (val) {
            print(val);
            return null;}
      ),
      Padding(
        padding: EdgeInsets.only(
        bottom: 16
        ),
      ),
    ]
  );
}
import 'package:flutter/material.dart';
import 'package:cal_app/models/event.dart';
import 'package:cal_app/themes/theme.dart';

class eventBox extends StatefulWidget {
  final Event? event;

  const eventBox(this.event);

  @override
  State<eventBox> createState() => _eventBox();

}

class _eventBox extends State<eventBox> {
  late Event event;
  late int? id;
  late String name;
  late String description;
  late int repeatFrequency;
  late int duration;
  late DateTime dueDate;

  @override
  void initState(){
    super.initState();
    name = widget.event?.name ?? '';
    id = widget.event?.id;
    description = widget.event?.description ?? '';
    repeatFrequency = widget.event?.repeatFrequency ?? 0;
    duration = widget.event?.duration ?? 0;
    dueDate = widget.event?.dueDate ?? DateTime.now();
    event = Event(id: id, repeatFrequency: repeatFrequency, dueDate: dueDate, name: name, description: description, duration: duration);
  }

  void submit() {

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

            Padding(
              padding: EdgeInsets.only(
                top: 5,
              ),
              child: Text(
                Duration == 0 ?
                dueDate.hour.toString() :
                dueDate.hour.toString() + " - " + (dueDate.hour + duration).toString(),
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
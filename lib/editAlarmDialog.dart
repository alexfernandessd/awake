import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class EditAlarmDialog extends StatefulWidget  {
  final Function callBack;
  final DateTime time;
  final String description;
  final int index;
  const EditAlarmDialog({Key key, this.callBack, this.time, this.description, this.index}) : super(key: key);

  @override
  AlarmDialog createState() => AlarmDialog();
}

class AlarmDialog extends State<EditAlarmDialog> {
  final format = DateFormat("HH:mm");
  DateTime time;
  String description;

  @override
  void initState() {
    super.initState();
  }

  editAlarm(){
    widget.callBack(time, description, widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add alarm'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DateTimePickerFormField(
              inputType: InputType.time,
              style: TextStyle(
                fontSize: 100.0,
              ),
              format: DateFormat("HH:mm"),
              initialValue: widget.time,
              editable: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hasFloatingPlaceholder: false,
              ),
              onChanged: (tm) {
                setState(() => time = tm);
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: widget.description,
              ),
              onChanged: (desc) {
                setState(() => description = desc);
              },
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          child: Text("Edit"),
          onPressed: () {
            editAlarm();
            Navigator.pop(this.context);
          },
        ),
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(this.context);
          },
        ),
      ],
    );
  }
}

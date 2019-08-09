import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class AddAlarmDialog extends StatefulWidget  {
  final Function callBack;
  const AddAlarmDialog({Key key, this.callBack}) : super(key: key);

  @override
  AlarmDialog createState() => AlarmDialog();
}

class AlarmDialog extends State<AddAlarmDialog> {
  final format = DateFormat("HH:mm");
  DateTime time = DateTime.now();
  String description;

  @override
  void initState() {
    super.initState();
  }

  addAlarm(){
    widget.callBack(time, description);
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
              initialValue: time,
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
                hintText: 'Why this alarm?',
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
          child: Text("Add"),
          onPressed: () {
            addAlarm();
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

import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class AlarmDialog extends StatefulWidget {
  final Function callBack;
  final DateTime time;
  final String description;
  final int index;
  const AlarmDialog({Key key, this.callBack, this.time, this.description, this.index})
      : super(key: key);

  @override
  _AlarmDialog createState() => _AlarmDialog();
}

class _AlarmDialog extends State<AlarmDialog> {
  DateTime time;
  String description;

  @override
  void initState() {
    if (widget.time == null) {
      time = DateTime.now();
    } else {
      time = widget.time;
    }
    super.initState();
  }

  actionAlarm() {
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
          child: Text(widget.index == null ? "Add" : "Edit"),
          onPressed: () {
            actionAlarm();
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

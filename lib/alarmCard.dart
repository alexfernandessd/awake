import 'package:flutter/material.dart';

class AlarmCard extends StatefulWidget {
  final dynamic callBackAlarmDialog;
  final Function callBackDeleteAlarm;
  final DateTime time;
  final String description;
  final int index;
  const AlarmCard(
      {Key key,
      this.callBackAlarmDialog,
      this.callBackDeleteAlarm,
      this.time,
      this.description,
      this.index})
      : super(key: key);

  @override
  _AlarmCard createState() => _AlarmCard();
}

class _AlarmCard extends State<AlarmCard> {
  String timeString;
  @override
  void initState() {
    super.initState();
    timeString =
        widget.time.hour.toString() + ":" + widget.time.minute.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          widget.callBackAlarmDialog(
              time: widget.time,
              description: widget.description,
              index: widget.index);
        },
        child: Row(children: <Widget>[
          Expanded(
            flex: 80,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      timeString,
                      style: TextStyle(
                        fontSize: 90.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 40.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 20,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  alignment: Alignment(0.5, 0),
                  child: InkWell(
                    onTap: () {
                      widget.callBackDeleteAlarm(widget.index);
                    },
                    child: new FloatingActionButton(
                      backgroundColor: Colors.red,
                      onPressed: null,
                      tooltip: 'Remove Alarm',
                      child: Icon(Icons.delete),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

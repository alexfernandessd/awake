import 'package:flutter/material.dart';
import 'package:awake/alarmDialog.dart';
import 'package:awake/alarmCard.dart';
import 'package:awake/alarms.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awake',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Awake'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final List<Alarm> alarms = [];

  alarmDialog({DateTime time, String description, int index}) {
    var context = this.context;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlarmDialog(
            callBack: alarmCallBack,
            time: time,
            description: description,
            index: index,
          );
        });
  }

  removeAlarm(int index) {
    setState(() {
      alarms.removeAt(index);
    });
  }

  makeCard(DateTime time, String description, int index) {
    return new AlarmCard(
        callBackAlarmDialog: alarmDialog,
        callBackDeleteAlarm: removeAlarm,
        time: time,
        description: description,
        index: index);
  }

  alarmCallBack(DateTime time, String description, int index) {
    if (index == null) {
      Alarm newAlarm = Alarm(time, description);
      setState(() {
        alarms.add(newAlarm);
      });
    } else {
      Alarm newAlarm = Alarm(time, description);
      setState(() {
        alarms[index] = newAlarm;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: new ListView.builder(
          itemCount: alarms.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(
              alarms[index].time,
              alarms[index].description,
              index,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: alarmDialog,
        tooltip: 'Add Alarm',
        child: Icon(Icons.add),
      ),
    );
  }
}

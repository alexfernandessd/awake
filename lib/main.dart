import 'package:flutter/material.dart';
import 'package:awake/addAlarmDialog.dart';
import 'package:awake/editAlarmDialog.dart';
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

  static final List<Alarm> alarms = [];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  addAlarmDialog() {
    var context = this.context;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AddAlarmDialog(callBack: addAlarmCallBack);
      },
    );
  }

  editAlarmDialog(DateTime time, String description, int index) {
    var context = this.context;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new EditAlarmDialog(callBack: editAlarmCallBack, time: time, description: description, index: index,);
        });
  }

  makeCard(DateTime time, String description, int index) {
    var timeString = time.hour.toString() + ":" + time.minute.toString();
    return Card(
      child: GestureDetector(
        onTap: () {
          editAlarmDialog(time, description, index);
        },
        child: new Text(
          timeString,
          style: TextStyle(
            fontSize: 100.0,
          ),
        ),
      ),
    );
  }

  addAlarmCallBack(DateTime time, String description) {
    Alarm newAlarm = Alarm(time, description);
    setState(() {
      MyHomePage.alarms.add(newAlarm);
    });
  }

  editAlarmCallBack(DateTime time, String description, int index) {
    Alarm newAlarm = Alarm(time, description);
    setState(() {
      MyHomePage.alarms.removeAt(index);
      MyHomePage.alarms.add(newAlarm);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: new ListView.builder(
          itemCount: MyHomePage.alarms.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(
              MyHomePage.alarms[index].time,
              MyHomePage.alarms[index].description,
              index,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addAlarmDialog,
        tooltip: 'Add Alarm',
        child: Icon(Icons.add),
      ),
    );
  }
}

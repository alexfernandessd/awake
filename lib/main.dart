import 'package:flutter/material.dart';
import 'package:awake/alarmDialog.dart';
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

    if (index == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlarmDialog(
            callBack: alarmCallBack,
            index: null,
          );
        },
      );
    } else {
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
  }

  makeCard(DateTime time, String description, int index) {
    var timeString = time.hour.toString() + ":" + time.minute.toString();
    return Card(
      child: InkWell(
        onTap: () {
          alarmDialog(time: time, description: description, index: index);
        },
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Column(children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    timeString.toString(),
                    style: TextStyle(
                      fontSize: 90.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 50.0,
                    ),
                  ),
                ],
              )
            ]),
            Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  alignment: Alignment(1, 0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        alarms.removeAt(index);
                      });
                    },
                    child: new FloatingActionButton(
                      onPressed: null,
                      tooltip: 'Remove Alarm',
                      child: Icon(Icons.delete),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ]),
      ),
    );
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

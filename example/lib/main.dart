import 'package:calendar_calendar/calendar_calendar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Calendar'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Calendar(
                weekendOpacityEnable: true,
                previous: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            spreadRadius: 1.5,
                            blurRadius: 5,
                            offset: Offset(2.0, 0.0))
                      ]),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: Colors.orange,
                    ),
                  ),
                ),
                next: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            spreadRadius: 1.5,
                            blurRadius: 5,
                            offset: Offset(2.0, 0.0))
                      ]),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.orange,
                    ),
                  ),
                ),
                space: 20,
                onSelected: print,
                backgroundColor: Colors.white,
                activeColor: Colors.orange,
                textStyleDays: TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black),
                textStyleWeekDay:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                titleStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                selectedStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

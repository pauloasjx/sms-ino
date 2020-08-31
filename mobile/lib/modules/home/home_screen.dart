import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example"),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          crossAxisCount: 2,
          children: List.generate(8, (index) {
            return InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: () {
                sendSMS(message: "test", recipients: ["42998694213"]).then((value) {
                  print(value);
                });
              },
              child: Ink(
                child: Center(
                  child: Text('Example'.toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sms_control/models/relay.dart';
import 'package:sms_control/static.dart';
import 'package:sms_control/widgets/base_button.dart';
import 'package:sms_control/widgets/base_card.dart';
import 'package:sms_control/widgets/base_outline_button.dart';
import 'package:sms_control/widgets/base_outline_title.dart';

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
        body: SafeArea(
          child: Container(
      margin: EdgeInsets.all(8.0),
      child: ListView(
          children: [
//            Text("Controle".toUpperCase(),
//                style: TextStyle(
//                    color: Colors.red,
//                    fontWeight: FontWeight.bold,
//                    fontSize: 32.0)),
            SizedBox(height: 8.0),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {

                Relay relay = grelays[index];

                return Container(
                  margin: EdgeInsets.all(4.0),
                  child: BaseCard(
                    child: Container(
                      margin: EdgeInsets.all(32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.device_hub),
                              SizedBox(width: 4.0),
                              Text(relay.name.toUpperCase(),
                                  style: TextStyle(fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Row(
                            children: [
                              BaseButton(
                                onTap: relay.timer,
                                icon: Icon(Icons.timer, color: Colors.white),
                                color: Colors.blue,
                              ),
                              SizedBox(width: 8.0),
                              BaseButton(
                                onTap: relay.start,
                                icon: Icon(Icons.lightbulb_outline,
                                    color: Colors.white),
                                color: Colors.green,
                              ),
                              SizedBox(width: 8.0),
                              BaseButton(
                                onTap: relay.shutdown,
                                icon: Icon(Icons.remove, color: Colors.white),
                                color: Colors.red,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 2.0);
              },
              itemCount: grelays.length,
            ),
            SizedBox(height: 8.0),
            BaseOutlineButton(
              child: BaseOutlineButtonTitle("Desligar Todos".toUpperCase(),
                  color: Colors.red),
              onPressed: () {},
            )
          ],
      ),
    ),
        ));
  }
}

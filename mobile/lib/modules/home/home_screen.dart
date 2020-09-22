import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
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
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: selected.isNotEmpty
            ? FloatingActionButton.extended(
                backgroundColor: Colors.black,
                onPressed: () {
                  sendSMS(message: selected.join(" "), recipients: grecipients)
                      .then((value) {
                    print(value);
                  });
                },
                label: Text("Enviar".toUpperCase()),
                icon: Icon(Icons.send))
            : Container(),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(8.0),
            children: [
              SizedBox(height: 8.0),
              Text("Controle SMS",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0)),
              SizedBox(height: 4.0),
              Text(
                  "Mensagens enviadas para os números: \n" +
                      grecipients.join(", "),
                  style: TextStyle(fontWeight: FontWeight.w300)),
              SizedBox(height: 4.0),
              selected.isNotEmpty ? Text("Mensagem atual: \n" + selected.join(" "),
                  style: TextStyle(fontWeight: FontWeight.w300)) : Container(),
              SizedBox(height: 12.0),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Row(
                              children: [
                                BaseButton(
                                  halfOpacity: !selected.contains(relay.timer),
                                  onTap: () {
                                    setState(() {
                                      if (selected.contains(relay.timer)) {
                                        selected.remove(relay.timer);
                                      } else {
                                        selected.remove(relay.shutdown);
                                        selected.remove(relay.start);
                                        selected.add(relay.timer);
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.timer, color: Colors.white),
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 8.0),
                                BaseButton(
                                  halfOpacity: !selected.contains(relay.start),
                                  onTap: () {
                                    setState(() {
                                      if (selected.contains(relay.start)) {
                                        selected.remove(relay.start);
                                      } else {
                                        selected.remove(relay.shutdown);
                                        selected.remove(relay.timer);
                                        selected.add(relay.start);
                                      }
                                    });
                                  },
                                  icon: Icon(Icons.lightbulb_outline,
                                      color: Colors.white),
                                  color: Colors.green,
                                ),
                                SizedBox(width: 8.0),
                                BaseButton(
                                  halfOpacity:
                                      !selected.contains(relay.shutdown),
                                  onTap: () {
                                    setState(() {
                                      if (selected.contains(relay.shutdown)) {
                                        selected.remove(relay.shutdown);
                                      } else {
                                        selected.remove(relay.timer);
                                        selected.remove(relay.start);
                                        selected.add(relay.shutdown);
                                      }
                                    });
                                  },
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
              Opacity(
                opacity: selected.contains("PPPINFO") ? 1.0 : 0.5,
                child: BaseOutlineButton(
                  color: Colors.yellow[900],
                  child: BaseOutlineButtonTitle(
                      "Quais estão ligados?".toUpperCase(),
                      color: Colors.yellow[900]),
                  onPressed: () {
                    setState(() {
                      if (selected.contains("PPPINFO")) {
                        selected.remove("PPPINFO");
                      } else {
                        selected.add("PPPINFO");
                      }
                    });
                  },
                ),
              ),
              SizedBox(height: 8.0),
              Opacity(
                opacity: selected.contains("PPPDTODOS") ? 1.0 : 0.5,
                child: BaseOutlineButton(
                  color: Colors.red,
                  child: BaseOutlineButtonTitle("Desligar Todos".toUpperCase(),
                      color: Colors.red),
                  onPressed: () {
                    setState(() {
                      if (selected.contains("PPPDTODOS")) {
                        selected.remove("PPPDTODOS");
                      } else {
                        selected.add("PPPDTODOS");
                      }
                    });
                  },
                ),
              )
            ],
          ),
        ));
  }
}

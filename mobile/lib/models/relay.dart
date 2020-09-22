import 'package:sms_control/static.dart';

class Relay {
  String name;
  String code;

  Relay(this.name, this.code);


  String get shutdown => gshutdown+code;
  String get timer => gtimer+code;
  String get start => gstart+code;
}

import 'package:flutter_sms/flutter_sms.dart';
import 'package:sms_control/static.dart';

class Relay {
  String name;
  String code;

  Relay(this.name, this.code);

  shutdown() => sendSMS(message: gshutdown + code, recipients: grecipients);

  timer() => sendSMS(message: gtimer + code, recipients: grecipients);

  start() => sendSMS(message: gstart + code, recipients: grecipients);
}

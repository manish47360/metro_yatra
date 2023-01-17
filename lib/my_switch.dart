import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:metro_yatra/services/location_service.dart';
import 'package:metro_yatra/services/notification_service.dart';
import 'package:metro_yatra/services/service_locator.dart';

var notificationService = locator<NotificationService>();
class MySwitch extends StatefulWidget {
  const MySwitch({Key? key}) : super(key: key);

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  bool light = false;

  @override
  Widget build(BuildContext context) {
    final service = FlutterBackgroundService();
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.blue,
      onChanged: (bool value) async {
        if (value){
          print('if value: $value');
          if (await requestAccessAndPermission()) {
            service.startService();
          }
        }else{
          print('else value: $value');
          service.invoke('stopService');
          service.on('serviceStopped').listen((event) {setState(() {
            print('event: ${event!['message']}');
          });});
        }
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}

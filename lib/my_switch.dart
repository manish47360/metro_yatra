import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:metro_yatra/services/destination_alert_service.dart';

class MySwitch extends StatefulWidget {
  const MySwitch({Key? key}) : super(key: key);

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  bool light = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.blue,
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        DestinationAlertService([]).alert();
        print('Switch Running');
        setState(() {
          light = value;
        });
      },
    );
  }


}

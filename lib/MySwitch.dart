import 'package:flutter/material.dart';

class MySwitch extends StatefulWidget {
  const MySwitch({Key? key}) : super(key: key);

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(light ? 'On': 'Off'),
        Switch(
          // This bool value toggles the switch.
          value: light,
          activeColor: Colors.blue,
          onChanged: (bool value) {
            // This is called when the user toggles the switch.
            setState(() {
              light = value;
            });
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rolling_switch/rolling_switch.dart';

import 'MySwitch.dart';

class MetroRoute extends StatelessWidget {
  const MetroRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'Set Alert',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                MySwitch()
              ],
            ),
            Row(),
          ],
        ),
      ),
    );
  }
}

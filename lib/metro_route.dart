import 'package:flutter/material.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Set Alert',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                MySwitch()
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Material(
              elevation: 15,
              child: Container(
                padding: const EdgeInsets.only(bottom: 15),
                height: 70,
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Expanded(
                      child: SizedBox(
                        width: 200,
                        height: 150,
                        child: Center(
                          child: Text(
                            'Station',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 200,
                        height: 150,
                        child: Center(
                          child: Text(
                            'Fair and Time',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 200,
                        height: 150,
                        child: Center(
                          child: Text(
                            'Interchange',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

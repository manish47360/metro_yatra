import 'package:flutter/material.dart';
import 'package:metro_yatra/card.dart';
import 'package:metro_yatra/route_interchange.dart';
import 'package:metro_yatra/route_station.dart';

import 'MySwitch.dart';

class MetroRoute extends StatelessWidget {
  const MetroRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Route'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.purpleAccent,
            padding: const EdgeInsets.only(top: 5),
            child: Card(
              color: Colors.grey.shade200,
              child: SizedBox(
                height: 220,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Expanded(
                          child: MyCard(
                            Icons.door_sliding_outlined,
                            '9',
                            'Station',
                          ),
                        ),
                        Expanded(
                          child: MyCard(
                              Icons.directions_run_rounded, '2', 'Interchange'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Expanded(
                          child: MyCard(Icons.currency_rupee, '20', 'Fare'),
                        ),
                        Expanded(
                            child: MyCard(
                          Icons.watch_later_outlined,
                          '20',
                          'Time',
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: const [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Notify when my destination station is near or their is any interchange of lines',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          MySwitch()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          RouteStation(
            station: StationRoute.START,
            lineColor: StationLineColor('blue'),
          ),
          RouteStation(
            station: StationRoute.INTERMEDIATE,
            lineColor: StationLineColor('green'),
          ),
          RouteStation(
            station: StationRoute.END,
            lineColor: StationLineColor(''),
          ),
          const RouteInterchange(),
        ],

      ),
    );
  }
}

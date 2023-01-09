import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:metro_yatra/bottom_navigation_route.dart';
import 'package:metro_yatra/metro_route.dart';
import 'package:metro_yatra/my_alert_dialog.dart';
import 'package:metro_yatra/select_station.dart';
import 'package:metro_yatra/select_station_button.dart';
import 'package:metro_yatra/services/station_service.dart';

class Metro extends StatefulWidget {
  const Metro({Key? key}) : super(key: key);

  @override
  _MetroState createState() => _MetroState();
}

class _MetroState extends State<Metro> {
  StationCode? departStation;// = 'Depart Station';
  StationCode? destinationStation;// = 'Destination Station';

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    StationCode result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StationListRoute()),
    ) as StationCode;
    if (!mounted) return;
    setState(() => departStation = result);
  }

  Future<void> _destinationStation(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    StationCode result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StationListRoute()),
    ) as StationCode;
    if (departStation == result) {
      showDialog(
          context: context,
          builder: (context) {
            return MyAlertDialog('Select Route',
                'Destination station can not be same as depart station. Please select different station.');
          });
      return;
    }
    if (!mounted) return;
    setState(() => destinationStation = result);
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/dmrc.png'))),
        //height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Card(
            color: Colors.grey,
            child: SizedBox(
              //width: 100,
              height: 370,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SelectStationButton(
                      departStation == null ? 'Depart Station' : departStation!.name, _navigateAndDisplaySelection),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        if (departStation == null ||
                            destinationStation == null) {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                MyAlertDialog(
                                    'Select Route', 'Please select station'),
                          );
                          return;
                        }
                        setState(() {
                          final temp = departStation;
                          departStation = destinationStation;
                          destinationStation = temp;
                        });
                      },
                      backgroundColor: Colors.grey,
                      child:
                      const Icon(Icons.import_export_rounded, size: 30),
                    ),
                  ),
                  SelectStationButton(
                      destinationStation == null ? 'Destination Station' : destinationStation!.name, _destinationStation),
                  const SizedBox(height: 15),
                  Card(
                    color: Colors.white,
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            (Icons.calendar_month),
                            size: 40.0,
                          ),
                          Text(
                            '${today.day}-${today.month}-${today.year}',
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 30.0,
                          ),
                          const Icon(
                            (Icons.timer_outlined),
                            size: 40.0,
                          ),
                          Text(
                            '${today.hour}:${today.minute}:${today.second}',
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MetroRoute(departStation: departStation!.code, destinationStation: destinationStation!.code,),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 60),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                        alignment: Alignment.center,
                        backgroundColor: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Show Route',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        shape: const CircularNotchedRectangle(),
        color: Colors.black87,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            BottomNavigationRoute(
                nextPageName: 'station_facility_list',
                routeName: 'Station Facility',
                icon: Icons.tag_faces),
            BottomNavigationRoute(
                nextPageName: 'nearest_metro',
                routeName: 'Near by Station',
                icon: Icons.train_outlined),
            BottomNavigationRoute(
                nextPageName: 'first_last_metro',
                routeName: 'Last Metro',
                icon: Icons.watch_later_outlined),
          ],
        ),
      ),
    );
  }
}

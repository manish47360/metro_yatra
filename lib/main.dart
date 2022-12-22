
import 'package:flutter/material.dart';
import './metro_route.dart';
import './first_last_metro.dart';
import './metro_login.dart';
import './nearest_metro.dart';
import './select_station.dart';
import './station_facility.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'metro_login',
    routes: {
      'metro_login':(context) => const Metro(),
      'select_station': (context) => const StationList(),
      'station_facility': (context) => const Facility(),
      'first_last_metro': (context) => const FirstLastMetro(),
      'nearest_metro': (context) => const NearestStation(),
      'metro_route': (context) => const MetroRoute()
    },
  ));
}


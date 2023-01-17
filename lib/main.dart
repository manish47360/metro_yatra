import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:metro_yatra/select_station_facility.dart';
import './first_last_metro.dart';
import './metro_login.dart';
import './nearest_metro.dart';
import 'services/service_locator.dart';

void main({String? env}) {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(env);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'metro_login',
      routes: {
        'metro_login': (context) => const Metro(),
        'station_facility_list': (context) => const StationFacilityList(),
        'first_last_metro': (context) => const FirstLastMetro(),
        'nearest_metro': (context) => const NearestStation()
      },
    ),
  );
}

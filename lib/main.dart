import 'package:flutter/material.dart';
import 'package:metro_yatra/select_station_facility.dart';
import 'package:metro_yatra/services/notification_service.dart';
import './first_last_metro.dart';
import './metro_login.dart';
import './nearest_metro.dart';
import './station_facility.dart';
import './service_locator.dart';

Future<void> main({String? env}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
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

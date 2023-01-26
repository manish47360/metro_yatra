import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:metro_yatra/select_station_facility.dart';
import 'package:metro_yatra/services/notification_service.dart';
import 'package:metro_yatra/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './destination_alert.dart';
import './metro_login.dart';
import './nearest_metro.dart';
import 'services/service_locator.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void clearRoute() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  await prefs.remove(StorageService.routeStations);
}
void cleanUp() async {
  var notificationService = locator<NotificationService>();
  notificationService.stopService();
  notificationService.cancelAllNotifications();
  debugPrint('app killed');
}
void main({String? env}) {
  WidgetsFlutterBinding.ensureInitialized();
  clearRoute();
  setupLocator(env);
  WidgetsBinding.instance.addObserver(LifecycleEventHandler(detachedCallBack: cleanUp));
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'metro_login',
      routes: {
        'metro_login': (context) => const Metro(),
        'station_facility_list': (context) => const StationFacilityList(),
        'destination_alert': (context) => const DestinationAlert(),
        'nearest_metro': (context) => const NearestStation()
      },
      navigatorKey: navigatorKey,
    ),
  );
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler({this.resumeCallBack, this.detachedCallBack});

  final VoidCallback? resumeCallBack;
  final VoidCallback? detachedCallBack;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.detached:
        detachedCallBack!();
        break;
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
        // TODO: Handle this case.
        break;
    }
  }
}

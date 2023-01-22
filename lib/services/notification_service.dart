import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';
import 'package:metro_yatra/services/location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../delhi_metro_route_response.dart';

const notificationChannelId = 'my_foreground';
const notificationID = 999;

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  var routeStations = prefs.getString('route-stations');
  if (routeStations == null){
    debugPrint('No Route Found');
    return;
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  DelhiMetroRouteResponse response = DelhiMetroRouteResponse.fromJson(jsonDecode(routeStations));
  List<MetroLineRoute> routes = response.route;
  int totalStations = routes
      .map((e) => e.path)
      .map((e) => e.length)
      .reduce((value, element) => value + element);
  debugPrint(
      'stations: $routes, totalLines: ${routes.length}, totalStations: $totalStations');
  debugPrint('onStart Called');
  var routeCounter = 0;
  var stationCounter = 0;

  Timer.periodic(
    const Duration(seconds: 15),
    (timer) async {
      final position = await determinePosition();
      if (routes.isNotEmpty) {
        final upComingRoute = routes[routeCounter];
        final upComingStation = upComingRoute.path[stationCounter];
        debugPrint('up coming route: $upComingRoute');
        debugPrint('up coming station: $upComingStation');
        final distanceBetween = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            upComingStation.latitude,
            upComingStation.longitude);
        debugPrint('distance: $distanceBetween');
        if (distanceBetween < 50) {
          stationCounter++;
          if (stationCounter >= upComingRoute.path.length) {
            debugPrint("Please interchange here.");
            routeCounter++;
            if (routeCounter >= routes.length) {
              debugPrint('You have arrived.');
              return;
            }
            stationCounter = 0;
          }
        }
      }
      debugPrint(
          'timer: ${DateTime.now()} - going on lat: ${position.latitude}, lng: ${position.longitude}');
      if (service is AndroidServiceInstance) {
        service.on('stopService').listen(
          (event) async {
            flutterLocalNotificationsPlugin.cancel(notificationID);
            await service.stopSelf();
          },
        );
        flutterLocalNotificationsPlugin.show(
          notificationID,
          'COOL SERVICE',
          'Awesome ${DateTime.now()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              notificationChannelId,
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
      }
    },
  );
}

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final NotificationService _notificationService =
      NotificationService._internal();
  final service = FlutterBackgroundService();

  /*factory NotificationService() {
    return _notificationService;
  }*/

  NotificationService._internal();

  static Future<NotificationService> getInstance() async {
    _notificationService._init();
    return _notificationService;
  }

  Future<void> startService() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      notificationChannelId, // id
      'MY FOREGROUND SERVICE', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.low, // importance must be at low or higher level
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await service.configure(
      iosConfiguration: IosConfiguration(
        onForeground: (service) => {},
        autoStart: false,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: false,
        autoStart: true,
        notificationChannelId: notificationChannelId,
        foregroundServiceNotificationId: notificationID,
      ),
    );
    service.startService();
  }

  Future<void> _init() async {
    debugPrint('initializing notification service');
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('metro_yatra');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) =>
          {debugPrint("payload: $payload}")},
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: selectNotification,
    );
    debugPrint('notification service have been initialized');
  }

  Future selectNotification(NotificationResponse response) async {
    if (kDebugMode) {
      debugPrint('Response: ${response.payload}');
    }
  }
}

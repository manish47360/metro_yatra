import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';
import 'package:metro_yatra/main.dart';
import 'package:metro_yatra/services/location_service.dart';
import 'package:metro_yatra/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../delhi_metro_route_response.dart';

const notificationChannelId = 'my_foreground';
const notificationID = 999;
const soundNotificationID = 998;
const channelTitle = 'MY FOREGROUND SERVICE';
const alertDistance = 60;
const nextStationCheckTimeInterval = 5;

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
  showNotification(flutterLocalNotificationsPlugin, 'Station: ${routes[0].path[0].name}');
  Timer.periodic(
    const Duration(seconds: nextStationCheckTimeInterval),
    (timer) async {
      Path? upComingStation;
      final position = await determinePosition();
      if (routes.isNotEmpty) {
        final upComingRoute = routes[routeCounter];
        upComingStation = upComingRoute.path[stationCounter];
        debugPrint('up coming route: $upComingRoute');
        debugPrint('up coming station: $upComingStation');
        showNotification(flutterLocalNotificationsPlugin, 'Next station: ${upComingStation.name}');
        final distanceBetween = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            upComingStation.latitude,
            upComingStation.longitude);
        debugPrint('distance: $distanceBetween');
        if (distanceBetween < alertDistance) {
          debugPrint("${upComingStation.name} Station Crossed");
          if (stationCounter == upComingRoute.path.length - 2){
            if (routes.length > 1){
              if (routeCounter == routes.length - 1){
                alertSoundNotification(flutterLocalNotificationsPlugin, "Please get down at the next station.");
                debugPrint("Please get down at the next station.");
              }else{
                alertSoundNotification(flutterLocalNotificationsPlugin, "Please interchange at the next station.");
                debugPrint("Please interchange at the next station.");
              }
            }else{
              alertSoundNotification(flutterLocalNotificationsPlugin, "Please get down at the next station.");
              debugPrint("Please get down at the next station.");
            }
          }
          stationCounter++;
          if (stationCounter >= upComingRoute.path.length) {
            routeCounter++;
            if (routeCounter >= routes.length) {
              alertSoundNotification(flutterLocalNotificationsPlugin, "You have arrived.");
              debugPrint('You have arrived.');
              flutterLocalNotificationsPlugin.cancel(notificationID);
              await prefs.clear();
              await prefs.remove(StorageService.routeStations);
              service.invoke('completed');
              await service.stopSelf();
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
            await flutterLocalNotificationsPlugin.cancel(notificationID);
            await service.stopSelf();
          },
        );
      }
    },
  );
}

void showNotification(final FlutterLocalNotificationsPlugin plugin, String body){
  plugin.show(
    notificationID,
    'Destination Alarm',
    body,
    // 'Next station: ${path == null ? '' : path.name}',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        notificationChannelId,
        channelTitle,
        icon: 'ic_bg_service_small',
        ongoing: true,
        playSound: false,
        enableVibration: false
      ),
    ),
  );
}

void alertSoundNotification(final FlutterLocalNotificationsPlugin plugin, String body){
  plugin.show(
    soundNotificationID,
    'Destination Alarm',
    body,
    // 'You have arrived at your destination',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'notificationChannelId',
        'channelTitle',
        icon: 'ic_bg_service_small',
        sound: RawResourceAndroidNotificationSound('a_long_cold_sting')
      ),
    ),
  );
}

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final NotificationService _notificationService =
      NotificationService._internal();
  final service = FlutterBackgroundService();

  NotificationService._internal();

  static Future<NotificationService> getInstance() async {
    _notificationService._init();
    return _notificationService;
  }

  void stopService(){
    service.invoke('stopService');
  }

  Future<void> startService() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      notificationChannelId, // id
      channelTitle, // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.defaultImportance, // importance must be at low or higher level
      playSound: false,
      enableVibration: false
    );
    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
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

  void cancelAllNotifications(){
    flutterLocalNotificationsPlugin.cancel(notificationID);
    flutterLocalNotificationsPlugin.cancel(soundNotificationID);
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
    navigatorKey.currentState?.pushNamed('destination_alert');
  }
}

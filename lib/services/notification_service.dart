import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:metro_yatra/services/location_service.dart';

const notificationChannelId = 'my_foreground';
const notificationID = 999;

Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  print('onStart Called');
  var counter = 40;
  // bring to foreground

  Timer.periodic(
    const Duration(seconds: 1),
    (timer) async {
      var position = await determinePosition();
      print('timer going on lat: ${position.latitude}, lng: ${position.longitude}');
      if (service is AndroidServiceInstance) {
        print('this is a foreground service');
        service.on('stopService').listen(
          (event) async {
            flutterLocalNotificationsPlugin.cancel(notificationID);
            service.invoke('serviceStopped', {'message': "Service Stopped"});
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

  /*factory NotificationService() {
    return _notificationService;
  }*/

  NotificationService._internal();

  static Future<NotificationService> getInstance() async {
    _notificationService._init();
    return _notificationService;
  }

  Future<void> _init() async {
    final service = FlutterBackgroundService();
    print('initializing notification service');
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
    service.configure(
        iosConfiguration:
            IosConfiguration(onForeground: (service) => {}, autoStart: false),
        androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          isForegroundMode: false,
          autoStart: false,
          notificationChannelId: notificationChannelId,
          foregroundServiceNotificationId: notificationID,
        ));
    print('notification service have been initialized');
  }

  Future selectNotification(NotificationResponse response) async {
    if (kDebugMode) {
      print('Response: ${response.payload}');
    }
  }
}

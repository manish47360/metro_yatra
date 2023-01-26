import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:metro_yatra/delhi_metro_route_response.dart';
import 'package:metro_yatra/services/location_service.dart';
import 'package:metro_yatra/services/notification_service.dart';
import 'package:metro_yatra/services/service_locator.dart';
import 'package:metro_yatra/services/storage_service.dart';

var notificationService = locator<NotificationService>();
var storageService = locator<StorageService>();
class MySwitch extends StatefulWidget {
  final DelhiMetroRouteResponse response;
  const MySwitch({super.key, required this.response});

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  bool light = false;
  final service = FlutterBackgroundService();

  @override
  void initState() {
    super.initState();
    light = storageService.isAlertPresent(widget.response.from, widget.response.to);
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.blue,
      onChanged: (value) async {
        var isRunning = await service.isRunning();
        if (value) {
          debugPrint('if value: $value');
          if (await requestAccessAndPermission()) {
            debugPrint("Routes: ${widget.response}");
            addAlert();
            if (!isRunning) {
              await notificationService.startService();
            }
          }
        } else {
          debugPrint('else value: $value');
          removeAlert();
          if (isRunning) {
            service.invoke('stopService');
          }
          /*service.on('serviceStopped').listen((event) {setState(() {
            debugPrint('event: ${event!['message']}');
          });});*/
        }
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }

  void addAlert() {
    storageService.setRouteStationsString(jsonEncode(widget.response));
    storageService.setStationAlert(widget.response.from, widget.response.to);
  }

  void removeAlert(){
    storageService.removeStations();
    storageService.removeStationAlert(widget.response.from, widget.response.to);
  }
}

import 'package:flutter/material.dart';
import 'package:metro_yatra/metro_route.dart';
import 'package:metro_yatra/services/service_locator.dart';
import 'package:metro_yatra/services/storage_service.dart';

var storageService = locator<StorageService>();

class DestinationAlert extends StatefulWidget {
  const DestinationAlert({Key? key}) : super(key: key);

  @override
  State<DestinationAlert> createState() => _DestinationAlertState();
}

class _DestinationAlertState extends State<DestinationAlert> {
  @override
  Widget build(BuildContext context) {
    var routeStations = storageService.getRouteStations();
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        backgroundColor: Colors.blue,
        title: const Text(
          "First Last Metro",
        ),
        centerTitle: true,
      ),
      body: routeStations != null
          ? RoutePage(routeStations)
          : const Center(
              child: Text('No Alerts!'),
            ),
    );
  }
}

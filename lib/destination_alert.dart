import 'package:flutter/material.dart';
import 'package:metro_yatra/delhi_metro_route_response.dart';
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
  late final DelhiMetroRouteResponse? routeStations;
  @override
  void initState() {
    super.initState();
    routeStations = storageService.getRouteStations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        backgroundColor: Colors.blue,
        title: const Text(
          "Destination Alert",
        ),
        centerTitle: true,
      ),
      body: routeStations != null
          ? RoutePage(routeStations!)
          : const Center(
              child: Text('No Alerts!'),
            ),
    );
  }
}

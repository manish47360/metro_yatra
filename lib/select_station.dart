import 'package:flutter/material.dart';
import 'package:metro_yatra/service_locator.dart';
import 'package:metro_yatra/services/station_service.dart';
import 'package:http/http.dart' as http;

var stationService = locator<StationService>();

class StationListRoute extends StatefulWidget {
  const StationListRoute({Key? key}) : super(key: key);

  @override
  State<StationListRoute> createState() => _StationListRouteState();
}

class _StationListRouteState extends State<StationListRoute> {
  StationList stationList = stationService.stationList;
  String search = '';
  final stationSelected = TextEditingController();
  final List<String> station = [
    "Dwarka",
    "Dwarka Mor",
    "Najafgarh",
    "New Delhi",
    "GTB Nagar"
  ];

  @override
  Widget build(BuildContext context) {
    List<ListTile> stationTiles = getListTiles(context, search);
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        backgroundColor: Colors.blue,
        title: const Text(
          "Station Facilities",
        ),
        centerTitle: true,
      ),
      body: Container(
        //height: MediaQuery.of(context).size.height * .2,
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() => search = value);
              },
              controller: stationSelected,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: stationTiles.length,
                itemBuilder: (context, index) {
                  return stationTiles[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ListTile> getListTiles(BuildContext context, String search) {
    return stationList.stationCodes
        .where((element) => search.isEmpty || element.name.toLowerCase().contains(search.toLowerCase()))
        .map(
          (e) => ListTile(
            title: Text(e.name),
            onTap: () => Navigator.pop(context, e),
          ),
        )
        .toList();
  }
}

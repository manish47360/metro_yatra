import 'package:flutter/material.dart';

class StationFacilityList extends StatefulWidget {
  const StationFacilityList({Key? key}) : super(key: key);

  @override
  State<StationFacilityList> createState() => _StationFacilityListState();
}

class _StationFacilityListState extends State<StationFacilityList> {
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
    return station
        .where((element) => search.isEmpty || element.startsWith(search))
        .map(
          (e) => ListTile(
            title: Text(e),
            onTap: () => Navigator.pushNamed(context, 'station_facility', arguments: e),
          ),
        )
        .toList();
  }
}

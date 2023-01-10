import 'package:flutter/material.dart';
import 'package:metro_yatra/select_station.dart';
import 'package:metro_yatra/services/station_service.dart';
import 'package:metro_yatra/station_facility.dart';

class StationFacilityList extends StatefulWidget {
  const StationFacilityList({Key? key}) : super(key: key);

  @override
  State<StationFacilityList> createState() => _StationFacilityListState();
}

class _StationFacilityListState extends State<StationFacilityList> {
  StationList stationList = stationService.stationList;
  String search = '';
  final stationSelected = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<ListTile> stationTiles = getListTiles(context, search);
    return Scaffold(
      appBar: AppBar(
        elevation: 15,
        backgroundColor: Colors.blue,
        title: const Text(
          "Search Station",
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
        .where((element) => search.isEmpty || element.name.toLowerCase().startsWith(search.toLowerCase()))
        .map(
          (e) => ListTile(
            title: Text(e.name),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) => Facility(stationCode: e),
            )),
          ),
        )
        .toList();
  }
}

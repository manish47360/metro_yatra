import 'package:flutter/material.dart';
import 'package:metro_yatra/services/nearby_station_service.dart';
import 'package:metro_yatra/services/service_locator.dart';

var routeService = locator<NearByStationService>();

class NearestStation extends StatefulWidget {
  const NearestStation({Key? key}) : super(key: key);

  @override
  State<NearestStation> createState() => _NearestStationState();
}

class _NearestStationState extends State<NearestStation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Nearest Metro Stations",
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<NearByStation>>(
        future: routeService.getStations(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NearByStationWidget(nearByStations: snapshot.data!);
          } else if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return const Center(child: Text('Near by stations not found.'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class NearByStationWidget extends StatelessWidget {
  final List<NearByStation> nearByStations;

  const NearByStationWidget({Key? key, required this.nearByStations})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: ListView.separated(
        itemBuilder: buildItems,
        separatorBuilder: (context, index) => const Divider(),
        itemCount: nearByStations.length,
      ),
    );
  }

  Widget buildItems(BuildContext context, int index) {
    final nextStation = nearByStations[index];
    return ListTile(
      leading: CircleAvatar(
        child: Text(nextStation.name[0]),
      ),
      title: Text(nextStation.name),
      subtitle: Text(nextStation.address),
    );
  }
}

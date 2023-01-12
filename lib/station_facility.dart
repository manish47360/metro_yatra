import 'package:flutter/material.dart';
import 'package:metro_yatra/delhi_metro_station_facilities.dart';
import 'package:metro_yatra/select_station.dart';
import 'package:metro_yatra/service_locator.dart';
import 'package:metro_yatra/services/facility_service.dart';
import 'package:http/http.dart' as http;
import 'package:metro_yatra/services/station_service.dart';

var facilityService = locator<FacilityService>();

class Facility extends StatefulWidget {
  final StationCode stationCode;

  const Facility({Key? key, required this.stationCode}) : super(key: key);

  @override
  State<Facility> createState() => _FacilityState();
}

class _FacilityState extends State<Facility> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.blue,
        title: const Text(
          "Station Facilities",
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<DelhiMetroStationFacilities>(
          future: facilityService.fetchFacilities(
              http.Client(), widget.stationCode.code),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.stackTrace);
              print(snapshot.error);
              return const Center(
                child: Text('An error has occurred.'),
              );
            } else if (snapshot.hasData) {
              return FacilityBody(snapshot.data!);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class FacilityBody extends StatelessWidget {
  final DelhiMetroStationFacilities response;

  const FacilityBody(this.response, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          //height: MediaQuery.of(context).size.height * .2,
          children: [
            getContact(response.landline, response.mobile),
            const Divider(
              thickness: 2.0,
              color: Colors.black87,
            ),
            const SizedBox(
              height: 5,
            ),
            gates(response.gate),
            const SizedBox(
              height: 5.0,
            ),
            const Divider(
              thickness: 2.5,
              color: Colors.black87,
            ),
            const SizedBox(
              height: 5,
            ),
            getFacility(response.facility),
            const SizedBox(
              height: 5.0,
            ),
            const Divider(
              thickness: 2.5,
              color: Colors.black87,
            ),
            const SizedBox(
              height: 5,
            ),
            getPlatforms(response.platform),
          ]),
    );
  }

  Widget gates(List<MetroGate> gates) {
    List<Widget> rows = [];
    for (MetroGate gate in gates) {
      rows.add(
        Row(
          children: [
            const Icon(Icons.door_sliding),
            const SizedBox(
              width: 20,
            ),
            Text(
              gate.gateName,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                gate.location,
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      );
    }
    return Column(
      children: [
        Row(
          children: const [
            Text(
              "Gates :",
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(
          thickness: 2.5,
          color: Colors.black87,
        ),
        const SizedBox(
          height: 5.0,
        ),
        ...rows
      ],
    );
  }

  Widget getContact(String landline, String mobile) {
    return Column(children: [
      Row(
        children: const [
          Padding(padding: EdgeInsets.only(top: 40)),
          //SizedBox(height: 10,),
          Text(
            "Contact :",
            style: TextStyle(
              fontSize: 20,
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      const Divider(
        thickness: 2.0,
        color: Colors.black87,
      ),
      Row(
        children: [
          const Icon(Icons.mobile_friendly_outlined),
          const SizedBox(width: 20),
          Text(
            mobile,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        children: [
          //const Padding(padding: EdgeInsets.only(left: 60)),
          const Icon(Icons.mobile_friendly_outlined),
          const SizedBox(
            width: 20,
          ),
          Text(
            landline,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    ]);
  }

  Widget getFacility(List<MetroFacility> facilities) {
    List<Widget> rows = [];
    for (MetroFacility facility in facilities) {
      rows.add(
        Row(
          children: [
            const Icon(Icons.add),
            const SizedBox(
              width: 20,
            ),
            Text(
              facility.kind,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      );
    }
    return Column(
      children: [
        Row(
          children: const [
            Text(
              "Facilities :",
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(
          thickness: 2.5,
          color: Colors.black87,
        ),
        const SizedBox(
          height: 5.0,
        ),
        ...rows
      ],
    );
  }

  Widget getPlatforms(List<MetroPlatform> platforms) {
    List<Widget> rows = [];
    for (MetroPlatform platform in platforms) {
      rows.add(
        Row(
          children: [
            const Icon(Icons.ev_station),
            Flexible(
              child: Card(
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [

                        Text(
                          platform.platformName,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Towards Station 1:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          platform.trainTowards.stationName,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Towards Station 2:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          platform.trainTowardsSecond != null ? platform.trainTowardsSecond!.stationName : 'NA',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      children: [
        Row(
          children: const [
            Text(
              "Platforms :",
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(
          thickness: 2.5,
          color: Colors.black87,
        ),
        const SizedBox(
          height: 5.0,
        ),
        ...rows
      ],
    );
  }
}

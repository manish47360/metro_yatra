import 'package:flutter/material.dart';
import 'package:metro_yatra/card.dart';
import 'package:metro_yatra/route_interchange.dart';
import 'package:metro_yatra/route_station.dart';
import 'package:metro_yatra/service_locator.dart';
import 'package:metro_yatra/services/route_service.dart';

import 'delhi_metro_route_response.dart';
import 'my_switch.dart';
import 'package:http/http.dart' as http;

var routeService = locator<RouteService>();

class MetroRoute extends StatelessWidget {
  final String departStation, destinationStation;

  const MetroRoute(
      {Key? key, required this.departStation, required this.destinationStation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Route'),
        ),
        body: FutureBuilder<DelhiMetroRouteResponse>(
          future: routeService.fetchRoutes(
              http.Client(), departStation, destinationStation),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.stackTrace);
              print(snapshot.error);
              return const Center(
                child: Text('An error has occurred.'),
              );
            } else if (snapshot.hasData) {
              return RoutePage(snapshot.data!);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ) /*,*/
        );
  }
}

class RoutePage extends StatelessWidget {
  final DelhiMetroRouteResponse response;

  const RoutePage(this.response, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.purpleAccent,
          padding: const EdgeInsets.only(top: 5),
          child: Card(
            color: Colors.grey.shade200,
            child: SizedBox(
              height: 220,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: MyCard(
                          Icons.door_sliding_outlined,
                          response.stations.toString(),
                          'Stations',
                        ),
                      ),
                      Expanded(
                        child: MyCard(
                          Icons.directions_run_rounded,
                          response.interchangeStations.toString(),
                          'Interchange',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: MyCard(Icons.currency_rupee,
                            response.fare.toString(), 'Fare'),
                      ),
                      Expanded(
                          child: MyCard(
                        Icons.watch_later_outlined,
                        response.totalTime,
                        'Time',
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Row(
                      children: const [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Notify when my destination station is near or their is any interchange of lines',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        MySwitch()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: response.route.length,
            itemBuilder: (context, index) {
              var route = response.route[index];
              return Column(
                  children: rows(route, index, response.route.length));
            },
          ),
        ),
      ],
    );
  }

  List<Widget> rows(MetroLineRoute route, int index, int routeLength) {
    List<Widget> rows = [];
    var lineColor = route.line.substring(0, route.line.indexOf(' '));
    int counter = 0;
    for (Path path in route.path) {
      rows.add(
        RouteStation(
          station: index == 0 && counter == 0
              ? StationRoute.START
              : index == routeLength - 1 && counter == route.path.length - 1
                  ? StationRoute.END
                  : StationRoute.INTERMEDIATE,
          lineColor: StationLineColor(lineColor),
          stationName: path.name,
          //stationCount: stationCount++,
        ),
      );
      counter++;
    }
    if (!(index == routeLength - 1 && counter == route.path.length)) {
      rows.add(const RouteInterchange());
    }
    return rows;
  }
}

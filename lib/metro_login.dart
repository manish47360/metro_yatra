import 'package:flutter/material.dart';
import 'package:metro_yatra/my_alert_dialog.dart';
import 'package:metro_yatra/select_station.dart';
import 'package:metro_yatra/select_station_button.dart';

class Metro extends StatefulWidget {
  const Metro({Key? key}) : super(key: key);

  @override
  _MetroState createState() => _MetroState();
}

class _MetroState extends State<Metro> {
  String departStation = 'Depart Station';
  String destinationStation = 'Destination Station';

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StationList()),
    );
    if (result == null) return;
    if (!mounted) return;
    setState(() => departStation = result);
  }

  Future<void> _destinationStation(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StationList()),
    );
    if (departStation == result) {
      showDialog(
          context: context,
          builder: (context) {
            return MyAlertDialog('Select Route',
                'Destination station can not be same as depart station. Please select different station.');
          });
      return;
    }
    if (!mounted) return;
    setState(() => destinationStation = result);
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/dmrc.png'))),
        //height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Card(
            color: Colors.grey.shade200,
            //padding: const EdgeInsets.only(top: 130),
            child: SizedBox(
              //width: 100,
              height: 370,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SelectStationButton(
                      departStation, _navigateAndDisplaySelection),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        if (departStation == 'Depart Station' ||
                            destinationStation == 'Destination Station') {
                          showDialog(
                            context: context,
                            builder: (context) => MyAlertDialog(
                                'Select Route', 'Please select station'),
                          );
                          return;
                        }
                        setState(() {
                          final temp = departStation;
                          departStation = destinationStation;
                          destinationStation = temp;
                        });
                      },
                      backgroundColor: Colors.grey,
                      child: const Icon(Icons.import_export_rounded, size: 30),
                    ),
                  ),
                  /*SizedBox(
                    height: 20.0,
                  ),*/
                  SelectStationButton(destinationStation, _destinationStation),
                  const SizedBox(height: 15),
                  Card(
                    color: Colors.white,
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            (Icons.calendar_month),
                            size: 40.0,
                          ),
                          Text(
                            '${today.day}-${today.month}-${today.year}',
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 30.0,
                          ),
                          const Icon(
                            (Icons.timer_outlined),
                            size: 40.0,
                          ),
                          Text(
                            '${today.hour}:${today.minute}:${today.second}',
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'metro_route');
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 60),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      alignment: Alignment.center,
                      backgroundColor: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Show Route', style: TextStyle(color: Colors.black87),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        shape: const CircularNotchedRectangle(),
        color: Colors.black87,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () =>
                  Navigator.pushNamed(context, 'station_facility_list'),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.tag_faces,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      "Station Facility",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, 'nearest_metro'),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.train_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      "Near by Station",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, 'first_last_metro'),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.watch_later_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text(
                      "Metro Time",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

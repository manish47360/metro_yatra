import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class RouteStation extends StatefulWidget {
  final StationRoute station;
  final StationLineColor lineColor;
  final String stationName;

  const RouteStation(
      {super.key,
      required this.station,
      required this.lineColor,
      required this.stationName});

  @override
  State<RouteStation> createState() => _RouteStationState();
}

class _RouteStationState extends State<RouteStation> {
  bool isFilled = false;
  final service = FlutterBackgroundService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: service.on(widget.stationName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          setState(() {
            isFilled = true;
          });
        }
        return _row();
      },
    );
  }

  Widget _row() {
    return Row(
      children: [
        SizedBox(
          height: 60,
          width: 40,
          child: Stack(
            children: [
              Align(
                alignment: widget.station == StationRoute.START
                    ? Alignment.bottomCenter
                    : widget.station == StationRoute.INTERMEDIATE
                        ? Alignment.center
                        : widget.station == StationRoute.END
                            ? Alignment.topCenter
                            : Alignment.center,
                child: Container(
                  width: 5,
                  height: widget.station == StationRoute.INTERMEDIATE ? 60 : 30,
                  color: Colors.black54,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: isFilled
                        ? widget.lineColor.actualColor
                        : Colors.transparent,
                    border: Border.all(color: widget.lineColor.actualColor),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
        Text('    ${widget.stationName} '),
      ],
    );
  }
}

enum StationRoute { START, INTERMEDIATE, END }

class StationLineColor {
  final String color;
  late final Color actualColor;

  StationLineColor(this.color) {
    actualColor = setActualColor(color);
  }

  Color setActualColor(String color) {
    switch (color.toLowerCase()) {
      case 'blue':
        return Color(0xFF2196F3);
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'red':
        return Color(0xFFF94336);
      case 'pink':
        return Color(0xFFF48FB1);
      case 'grey':
        return Colors.grey;
      case 'orange':
        return Colors.orange;
      case 'magenta':
        return Colors.pinkAccent;
      case 'violet':
        return Colors.purple;
      default:
        return Colors.blueGrey;
    }
  }
}

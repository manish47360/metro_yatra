import 'package:flutter/material.dart';

class RouteStation extends StatelessWidget {
  final StationRoute station;
  final StationLineColor lineColor;
  final String stationName;

  const RouteStation({super.key, required this.station, required this.lineColor, required this.stationName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 60,
          width: 40,
          child: Stack(
            children: [
              Align(
                alignment: station == StationRoute.START ? Alignment.bottomCenter : station == StationRoute.INTERMEDIATE ? Alignment.center : station == StationRoute.END ? Alignment.topCenter: Alignment.center,
                child: Container(
                  width: 5,
                  height: station == StationRoute.INTERMEDIATE ? 60 : 30,
                  color: Colors.black54,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: lineColor.actualColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
        Text('    $stationName '),
      ],
    );
  }
}

enum StationRoute{
  START,
  INTERMEDIATE,
  END
}

class StationLineColor{
  final String color;
  late final Color actualColor;
  StationLineColor(this.color){
    actualColor = setActualColor(color);
  }
  Color setActualColor(String color){
    switch(color.toLowerCase()){
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
import 'package:flutter/material.dart';

class RouteStation extends StatelessWidget {
  final StationRoute station;
  final StationLineColor lineColor;

  const RouteStation({super.key, required this.station, required this.lineColor});

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
                  child: const Text('1'),
                ),
              ),
            ],
          ),
        ),
        const Text('    Dwarka Mor '),
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
        return Colors.blue;
      case 'green':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
class DelhiMetroRouteResponse {
  int stations;
  String to;
  String from;
  String totalTime;
  double fare;
  List<Route> route;
  int interchangeStations;

  DelhiMetroRouteResponse(
      {required this.stations,
      required this.to,
      required this.from,
      required this.totalTime,
      required this.fare,
      required this.route,
      required this.interchangeStations});

  factory DelhiMetroRouteResponse.fromJson(Map<String, dynamic> json) {
    var routeList = json['route'] as List;
    return DelhiMetroRouteResponse(
        stations: json['stations'],
        fare: json['fare'],
        from: json['from'],
        to: json['to'],
        totalTime: json['total_time'],
        route: routeList.map((e) => Route.fromJson(e)).toList(),
        interchangeStations: routeList.length);
  }
}

class Route {
  String line;
  int lineNo;
  List<String> mapPath;
  List<Path> path;
  String towardsStation;
  String platformName;

  Route(
      {required this.line,
      required this.lineNo,
      required this.mapPath,
      required this.path,
      required this.towardsStation,
      required this.platformName});

  factory Route.fromJson(Map<String, dynamic> json) {
    var pathList = json['path'] as List;
    return Route(
        line: json['line'],
        lineNo: json['line_no'],
        mapPath: json['map-path'],
        path: pathList.map((e) => Path.fromJson(e)).toList(),
        towardsStation: json['towards_station'],
        platformName: json['platform_name']);
  }
}

class Path {
  String name;
  String status;

  Path(this.name, this.status);

  factory Path.fromJson(Map<String, dynamic> json) {
    return Path(json['name'], json['status']);
  }
}
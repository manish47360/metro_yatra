import 'dart:convert';

class DelhiMetroRouteResponse {
  int stations;
  String to;
  String from;
  String totalTime;
  int fare;
  List<MetroLineRoute> route;
  int interchangeStations;

  DelhiMetroRouteResponse({required this.stations,
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
        route: routeList.map((e) => MetroLineRoute.fromJson(e)).toList(),
        interchangeStations: routeList.length - 1);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data['stations'] = stations;
    data['fare'] = fare;
    data['from'] = from;
    data['to'] = to;
    data['total_time'] = totalTime;
    data['route'] = route.map((e) => e.toJson()).toList();
    return data;
  }
}

class MetroLineRoute {
  String line;
  int lineNo;
  List<String> mapPath;
  List<Path> path;
  String towardsStation;
  String platformName;

  MetroLineRoute({required this.line,
    required this.lineNo,
    required this.mapPath,
    required this.path,
    required this.towardsStation,
    required this.platformName});

  factory MetroLineRoute.fromJson(Map<String, dynamic> json) {
    var pathList = json['path'] as List;
    var mapPathList = List<String>.from(json['map-path']);
    return MetroLineRoute(
        line: json['line'],
        lineNo: json['line_no'],
        mapPath: mapPathList,
        path: pathList.map((e) => Path.fromJson(e)).toList(),
        towardsStation: json['towards_station'],
        platformName: json['platform_name']);
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['line'] = line;
    data['line_no'] = lineNo;
    data['map-path'] = mapPath;
    data['path'] = path.map((e) => e.toJson()).toList();
    data['towards_station'] = towardsStation;
    data['platform_name'] = platformName;
    return data;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class Path {
  String name;
  String status;
  String? code;
  double latitude;
  double longitude;

  Path(this.name, this.status, this.code, this.latitude, this.longitude);

  factory Path.fromJson(Map<String, dynamic> json) {
    return Path(json['name'], json['status'], json['code'], json['latitude'],
        json['longitude']);
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['status'] = status;
    data['code'] = code;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

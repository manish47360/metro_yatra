import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import 'service_locator.dart';

var appConfig = locator<AppConfig>();

class StationService {
  static final StationService _instance = StationService._internal();
  late final StationList stationList;
  StationService._internal();

  void _init() async {
    stationList = await _fetchStations(http.Client());
  }

  static Future<StationService> getInstance() async {
    _instance._init();
    return _instance;
  }

  Future<StationList> _fetchStations(http.Client client) async {
    String endpoint =
        '${appConfig.metroHost}${appConfig.stationEndpoint}';
    Uri uri = Uri.parse(endpoint);
    debugPrint('URI: $uri');
    var response = await client.get(uri);
    return compute(parseStations, response.body);
  }

  StationList parseStations(String responseBody) {
    if (kDebugMode) {
      debugPrint('response body: $responseBody');
    }
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    stationList = StationList.fromJson(parsed);
    return stationList;
  }

}

class StationList{
  List<StationCode> stationCodes;
  StationList(this.stationCodes);
  factory StationList.fromJson(List<dynamic> json){
    List<StationCode> stations = json.map((e) => StationCode.fromJson(e)).toList();
    return StationList(stations);
  }
}

class StationCode {
  final String code;
  final String name;

  StationCode(this.code, this.name);

  factory StationCode.fromJson(Map<String, dynamic> json) {
    return StationCode(json['stationCode'], json['stationName']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stationCode'] = code;
    data['stationName'] = name;
    return data;
  }
}

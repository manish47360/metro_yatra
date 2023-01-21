
import 'dart:convert';

import 'package:metro_yatra/delhi_metro_route_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService{
  static const String routeStations = 'route-stations';
  late final SharedPreferences prefs;
  static final StorageService _instance = StorageService._internal();
  StorageService._internal();

  static Future<StorageService> getInstance() async {
    _instance._init();
    return _instance;
  }

  void _init() async{
    prefs = await SharedPreferences.getInstance();
  }

  void setRouteStationsString(String value){
    prefs.setString(routeStations, value);
  }

  void removeStations(){
    prefs.remove(routeStations);
  }

  void setStationAlert(String from, String to){
    prefs.setBool('$from:$to', true);
  }

  void removeStationAlert(String from, String to){
    prefs.setBool('$from:$to', false);
  }

  bool isAlertPresent(String from, String to){
    return prefs.getBool('$from:$to') ?? false;
  }

  DelhiMetroRouteResponse? getRouteStations() {
    var stations = prefs.getString(routeStations);
    return stations != null ? DelhiMetroRouteResponse.fromJson(jsonDecode(stations)) : null;
  }
}
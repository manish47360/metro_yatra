
import 'dart:convert';

import 'package:metro_yatra/delhi_metro_route_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService{
  static const String routeStations = 'route-stations';
  late final SharedPreferences _prefs;
  static final StorageService _instance = StorageService._internal();
  StorageService._internal();

  static Future<StorageService> getInstance() async {
    await _instance._init();
    return _instance;
  }

  Future<void> _init() async{
    _prefs = await SharedPreferences.getInstance();
  }

  void setRouteStationsString(String value){
    _prefs.setString(routeStations, value);
  }

  void removeStations(){
    _prefs.remove(routeStations);
  }

  void setStationAlert(String from, String to){
    _prefs.setBool('$from:$to', true);
  }

  void removeStationAlert(String from, String to){
    _prefs.setBool('$from:$to', false);
  }

  void deleteStationAlert(String from, String to) async {
    await _prefs.remove('$from:$to');
  }

  void removeCurrentStationAlert() async {
    removeStations();
  }

  bool isAlertPresent(String from, String to){
    return _prefs.getBool('$from:$to') ?? false;
  }

  DelhiMetroRouteResponse? getRouteStations() {
    var stations = _prefs.getString(routeStations);
    return stations != null ? DelhiMetroRouteResponse.fromJson(jsonDecode(stations)) : null;
  }
}
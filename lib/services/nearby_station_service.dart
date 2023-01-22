import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:metro_yatra/config/app_config.dart';
import 'package:metro_yatra/services/location_service.dart';
import 'package:metro_yatra/services/service_locator.dart';
import 'package:http/http.dart' as http;


var appConfig = locator<AppConfig>();
class NearByStationService {
  static final NearByStationService _instance = NearByStationService._internal();
  NearByStationService._internal();
  static NearByStationService getInstance(){
    return _instance;
  }
  Future<List<NearByStation>> getStations() async {
    if (await requestAccessAndPermission()){
      var position = await determinePosition();
      final endpoint =
          '${appConfig.googleScrapperHost}/google/search/near-by-metro-stations?query=${position.latitude}, ${position.longitude}';
      var parse = Uri.parse(endpoint);
      debugPrint('URI: $parse');
      var response = await http.Client().get(parse);
      debugPrint('Google Response: ${response.body}');
      return compute(parseStation, response.body);
    }
    return Future.error(Exception());
  }

  List<NearByStation> parseStation(String responseBody){
    var parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    var list = parsed as List<dynamic>;
    return list.map((e) => NearByStation.fromJson(e)).toList();
  }

}

class NearByStation {
  String name;
  String address;
  String? phone;

  NearByStation(this.name, this.address, this.phone);

  factory NearByStation.fromJson(Map<String, dynamic> json){
    return NearByStation(json['name'], json['address'], json['phone']);
  }
}

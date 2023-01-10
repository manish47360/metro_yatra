
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../delhi_metro_station_facilities.dart';
import 'package:http/http.dart' as http;

class FacilityService{
  static FacilityService? _instance;
  static FacilityService getInstance(){
    return _instance ??= FacilityService();
  }
  Future<DelhiMetroStationFacilities> fetchFacilities(http.Client client , String stationCode) async{
    String endPoint = 'http://delhimetrobackendtest-env.eba-bvjxgwjk.ap-northeast-1.elasticbeanstalk.com/station-info/$stationCode/word';
    Uri uri = Uri.parse(endPoint);
    print('URI: $uri');
    final response = await client.get(uri);
    return compute(parseFacilities, response.body);
  }
  DelhiMetroStationFacilities parseFacilities(String responseBody){
    print('response body: $responseBody');
    final parsed = jsonDecode(responseBody);
    return DelhiMetroStationFacilities.fromJson(Map<String,dynamic>.from(parsed));
  }
}
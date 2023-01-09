import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:metro_yatra/delhi_metro_route_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RouteService{

  static RouteService? _instance;

  static RouteService getInstance() {
    return _instance ??= RouteService();
  }
  Future<DelhiMetroRouteResponse> fetchRoutes(
      http.Client client, String departStation, String destinationStation) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter =
    DateFormat('yyyy-MM-ddTHH:mm:ss'); //2023-01-06T07:57:31.103
    final String formattedDateTime = formatter.format(now);
    String endpoint =
        'http://delhimetrobackendtest-env.eba-bvjxgwjk.ap-northeast-1.elasticbeanstalk.com/delhi-metro-backend/route/$departStation/$destinationStation/short-distance/$formattedDateTime';
    Uri uri = Uri.parse(endpoint);
    print('URI: $uri');
    final response = await client.get(uri);
    return compute(parseRoutes, response.body);
  }

  DelhiMetroRouteResponse parseRoutes(String responseBody) {
    print('response body: $responseBody');
    final parsed = jsonDecode(responseBody);
    return DelhiMetroRouteResponse.fromJson(Map<String, dynamic>.from(parsed));
  }

}
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AppConfig{
  static String? env;
  late final String metroHost;
  late final String stationEndpoint;
  late final String stationInfoEndpoint;
  late final String searchStationsEndpoint;
  late final String googleScrapperHost;
  static AppConfig? _instance;

  AppConfig(Map<String, dynamic> json){
    _init(json);
  }

  static Future<AppConfig> getInstance(String? env) async {
    env ??= 'dev';
    AppConfig.env = env;
    final json = await forEnvironment(env);
    return _instance ?? AppConfig(json);
  }

  void _init(Map<String, dynamic> json) async {
    metroHost = json['metro-backend-url'];
    stationInfoEndpoint = json['stations-info'];
    stationEndpoint = json['stations-endpoint'];
    searchStationsEndpoint = json['search-stations'];
    googleScrapperHost = json['google-scrapper-host'];
  }

  static Future<Map<String, dynamic>> forEnvironment(String env) async {
    if (kDebugMode) {
      debugPrint('ENV: $env');
    }
    final jsonString = await rootBundle.loadString(
      'assets/dev.json',
    );
    return jsonDecode(jsonString);
  }

}
import 'package:get_it/get_it.dart';
import 'package:metro_yatra/services/station_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() async {
  var instance = StationService.getInstance();
  locator.registerSingleton<StationService>(instance);
}
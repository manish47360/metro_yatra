import 'package:get_it/get_it.dart';
import 'package:metro_yatra/config/app_config.dart';
import 'package:metro_yatra/services/facility_service.dart';
import 'package:metro_yatra/services/notification_service.dart';
import 'package:metro_yatra/services/route_service.dart';
import 'package:metro_yatra/services/station_service.dart';
import 'package:metro_yatra/services/storage_service.dart';

GetIt locator = GetIt.instance;

void setupLocator(String? env) async {
  locator.registerSingleton<AppConfig>(await AppConfig.getInstance(env));
  locator.registerSingleton<StationService>(await StationService.getInstance());
  locator.registerSingleton<RouteService>(RouteService.getInstance());
  locator.registerSingleton<FacilityService>(FacilityService.getInstance());
  locator.registerSingleton<NotificationService>(
      await NotificationService.getInstance());
  locator.registerSingleton(await StorageService.getInstance());
}

class DelhiMetroStationFacilities {
  String mobile;
  String landline;
  List<MetroGate> gate;
  List<MetroFacility> facility;
  List<MetroPlatform> platform;

  DelhiMetroStationFacilities(
      {required this.mobile,
      required this.landline,
      required this.gate,
      required this.facility,
      required this.platform});

  factory DelhiMetroStationFacilities.fromJson(Map<String, dynamic> json) {
    var gateList = json['metroGateDTO'] as List;
    var facilityList = json['stationFacilitiesDTO'] as List;
    var platformList = json['platformDTO'] as List;
    return DelhiMetroStationFacilities(
        mobile: json['mobile'],
        landline: json['landline'],
        gate: gateList.map((e) => MetroGate.fromJson(e)).toList(),
        facility: facilityList.map((e) => MetroFacility.fromJson(e)).toList(),
        platform: platformList.map((e) => MetroPlatform.fromJson(e)).toList());
  }
}

class MetroPlatform {
  TrainTowards trainTowards;
  TrainTowardsSecond? trainTowardsSecond;
  String platformName;

  MetroPlatform(
      {required this.platformName,
      required this.trainTowards,
      this.trainTowardsSecond});

  factory MetroPlatform.fromJson(Map<String, dynamic> json) {
    //var trainTowardsList = json['trainTowards'] as List;
    final second = json['trainTowardsSecond'];
    return second == null
        ? MetroPlatform(
            platformName: json['platformNames'],
            trainTowards: TrainTowards.fromJson(json['trainTowards']))
        : MetroPlatform(
            platformName: json['platformNames'],
            trainTowards: TrainTowards.fromJson(json['trainTowards']),
            trainTowardsSecond:
                TrainTowardsSecond.fromJson(json['trainTowardsSecond']));
  }
}

class TrainTowardsSecond {
  String stationName;

  TrainTowardsSecond({required this.stationName});

  factory TrainTowardsSecond.fromJson(Map<String, dynamic> json) {
    return TrainTowardsSecond(stationName: json['stationName']);
  }
}

class TrainTowards {
  String stationName;

  TrainTowards({required this.stationName});

  factory TrainTowards.fromJson(Map<String, dynamic> json) {
    return TrainTowards(stationName: json['stationName']);
  }
}

class MetroFacility {
  String kind;

  MetroFacility({required this.kind});

  factory MetroFacility.fromJson(Map<String, dynamic> json) {
    return MetroFacility(kind: json['kind']);
  }
}

class MetroGate {
  String gateName;
  String location;
  String status;
  bool divyangFriendly;

  MetroGate(
      {required this.gateName,
      required this.location,
      required this.status,
      required this.divyangFriendly});

  factory MetroGate.fromJson(Map<String, dynamic> json) {
    return MetroGate(
        gateName: json['gateName'],
        location: json['location'],
        status: json['status'],
        divyangFriendly: json['divyangFriendly']);
  }
}

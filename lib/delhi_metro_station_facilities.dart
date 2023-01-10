
class DelhiMetroStationFacilities{
  String mobile;
  String landline;
  List<MetroGate> gate;
  List<MetroFacility> facility;
  List<MetroPlatform> platform;
  DelhiMetroStationFacilities({
    required this.mobile,
    required this.landline,
    required this.gate,
    required this.facility,
    required this.platform
});
  factory DelhiMetroStationFacilities.fromJson(Map<String,dynamic> json){
    var gateList = json['metroGateDTO'] as List;
    var facilityList = json['stationFacilitiesDTO'] as List;
    var platformList = json['platformDTO'] as List;
    return DelhiMetroStationFacilities(
        mobile: json['mobile'],
        landline: json['landline'],
        gate: gateList.map((e) => MetroGate.fromJson(e)).toList(),
        facility: facilityList.map((e) => MetroFacility.fromJson(e)).toList(),
        platform: platformList.map((e) => MetroPlatform.fromJson(e)).toList()
    );
  }
}

class MetroPlatform {
  String platformName;
  MetroPlatform({
   required this.platformName
});
  factory MetroPlatform.fromJson(Map<String,dynamic> json){
    return MetroPlatform(platformName: json['platformNames']);
  }
}

class MetroFacility {
  String kind;
  MetroFacility({
    required this.kind
});
  factory MetroFacility.fromJson(Map<String , dynamic> json){
    return MetroFacility(kind: json['kind']);
  }
}

class MetroGate {
  String gateName;
  String location;
  String status;
  bool divyangFriendly;
  MetroGate({
   required this.gateName,
   required this.location,
   required this.status,
   required this.divyangFriendly 
 });
  factory MetroGate.fromJson(Map<String, dynamic> json){
    return MetroGate(gateName: json['gateName'],
        location: json['location'],
        status: json['status'],
        divyangFriendly: json['divyangFriendly']);
  }
}
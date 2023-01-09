class DelhiMetroStationFacilities{
  String mobile;
  String landline;
  DelhiMetroStationFacilities({
    required this.mobile,
    required this.landline
});
  factory DelhiMetroStationFacilities.fromJson(Map<String,dynamic> json){
    return DelhiMetroStationFacilities(
        mobile: json['mobile'],
        landline: json['landline']);
  }
}
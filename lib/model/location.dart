class LocationModel {
  final int? id;
  final String city;
  final String? region;
  final String? country;
  final double? latitude;
  final double? longitude;
  final String? timezone;

  const LocationModel(this.id, this.city, this.region, this.country, this.latitude, this.longitude, this.timezone);

  factory LocationModel.fromJSON(Map<String, dynamic> json) {
    int? id = json['id'];
    String city = json['city'];
    String? region = json['region'];
    String? country = json['country'];
    double? latitude = json['lat'];
    double? longitude = json['lon'];
    String? timezone = json['tz_id'];

    return LocationModel(id, city, region, country, latitude, longitude, timezone);
  }

  factory LocationModel.fromSearch(Map<String, dynamic> json) {
    String city = json['name'];
    String? region = json['region'];
    String? country = json['country'];
    double? latitude = json['lat'];
    double? longitude = json['lon'];

    return LocationModel(null, city, region, country, latitude, longitude, null);
  }

  String get query => region == null
    ? '$city,$country'
    : '$city,$region,$country';

  Map<String, dynamic> get toMap {
    return {
      'city': city,
      'region': region,
      'country': country,
      'lat': latitude,
      'lon': longitude,
      'tz_id': timezone
    };
  }
}
class CityModel {
  final String city;
  final String? state;
  final String country;

  const CityModel(this.city, this.state, this.country);

  factory CityModel.fromJSON(Map<String, dynamic> json) {
    String city = json['city'];
    String? state = json['state'];
    String country = json['country'];

    return CityModel(city, state, country);
  }

  String get query => state == null
    ? '$city,$country'
    : '$city,$state,$country';
}
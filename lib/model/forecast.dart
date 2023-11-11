class ForecastModel {
  final String main;
  final String description;
  final DateTime sunrise;
  final DateTime sunset;
  final int temperature;
  final int temperatureMin;
  final int temperatureMax;
  final int feelsLike;
  final int pressure;
  final int humidity;
  final int? airQuality;
  final int? dewPoint;
  final int? uvi;
  final int visibility;
  final int windSpeed;  
  final int windAngle;
  final int rain;
  final int snow;

  const ForecastModel(this.main, this.description, this.sunrise, this.sunset, this.temperature, this.temperatureMin, this.temperatureMax, this.feelsLike, this.pressure, this.humidity, this.airQuality, this.dewPoint, this.uvi, this.visibility, this.windSpeed, this.windAngle, this.rain, this.snow);

  factory ForecastModel.fromJSON(Map<String, dynamic> json) {
    String main = json['weather'][0]['main'];
    String description = json['weather'][0]['description'];
    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000, isUtc: true);
    DateTime sunset = DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000, isUtc: true);
    int temperature = json['main']['temp'].toInt();
    int temperatureMin = json['main']['temp_min'].toInt();
    int temperatureMax = json['main']['temp_max'].toInt();
    int feelsLike = json['main']['feels_like'].toInt();
    int pressure = json['main']['pressure'].toInt();
    int humidity = json['main']['humidity'].toInt();
    int? airQuality = json['air_quality']?.toInt();
    int? dewPoint = json['dew_point']?.toInt();
    int? uvi = json['uvi']?.toInt();
    int visibility = json['visibility'].toInt();
    int windSpeed = json['wind']['speed'].toInt();
    int windAngle = json['wind']['deg'].toInt();
    int rain = json['rain']?.toInt() ?? 0;
    int snow = json['snow']?.toInt() ?? 0;

    return ForecastModel(main, description, sunrise, sunset, temperature, temperatureMin, temperatureMax, feelsLike, pressure, humidity, airQuality, dewPoint, uvi, visibility, windSpeed, windAngle, rain, snow);
  }
}
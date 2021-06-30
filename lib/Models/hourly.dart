class HourlyWeatherResponce {
  final int dt;
  final double temp;
  final double feelsLike;
  final double pressure;
  final double wind;
  final String description;
  final String icon;

  HourlyWeatherResponce(
      {required this.dt,
      required this.temp,
      required this.feelsLike,
      required this.pressure,
      required this.wind,
      required this.description,
      required this.icon});

  factory HourlyWeatherResponce.fromJson(Map<String, dynamic> json) {
    final icon = json['weather'][0]['icon'];
    final iconUrl = 'http://openweathermap.org/img/wn/$icon@2x.png';

    return HourlyWeatherResponce(
      dt: json['dt'].toInt(),
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      pressure: json['pressure'].toDouble(),
      wind: json['wind_speed'].toDouble(),
      description: json['weather'][0]['description'],
      icon: iconUrl,
    );
  }
}

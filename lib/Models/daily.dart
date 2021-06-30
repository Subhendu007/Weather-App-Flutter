class DailyWeatherResponce {
  final int dt;
  final double temp;
  final double feelsLike;
  final double low;
  final double high;
  final String description;
  final double wind;
  final String icon;

  DailyWeatherResponce(
      {required this.dt,
      required this.temp,
      required this.feelsLike,
      required this.low,
      required this.high,
      required this.description,
      required this.wind,
      required this.icon});

  factory DailyWeatherResponce.fromJson(Map<String, dynamic> json) {
    final icon = json['weather'][0]['icon'];
    final iconUrl = 'http://openweathermap.org/img/wn/$icon@2x.png';

    return DailyWeatherResponce(
      dt: json['dt'].toInt(),
      temp: json['temp']['day'].toDouble(),
      feelsLike: json['feels_like']['day'].toDouble(),
      low: json['temp']['min'].toDouble(),
      high: json['temp']['max'].toDouble(),
      description: json['weather'][0]['description'],
      wind: json['wind_speed'].toDouble(),
      icon: iconUrl,
    );
  }
}

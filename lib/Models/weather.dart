class Weather {
  final double temp;
  final double feelsLike;
  final double low;
  final double high;
  final String description;
  final double pressure;
  final double humidity;
  final double wind;
  final String icon;
  final String cityName;
  final double lat;
  final double lon;
  final String country;

  Weather(
      {required this.lat,
      required this.lon,
      required this.cityName,
      required this.temp,
      required this.feelsLike,
      required this.low,
      required this.high,
      required this.description,
      required this.pressure,
      required this.humidity,
      required this.wind,
      required this.icon,
      required this.country});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final icon = json['weather'][0]['icon'];
    final iconUrl = 'http://openweathermap.org/img/wn/$icon@2x.png';

    return Weather(
      lat: json['coord']['lat'].toDouble(),
      lon: json['coord']['lon'].toDouble(),
      temp: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      low: json['main']['temp_min'].toDouble(),
      high: json['main']['temp_max'].toDouble(),
      description: json['weather'][0]['description'],
      pressure: json['main']['pressure'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      wind: json['wind']['speed'].toDouble(),
      icon: iconUrl,
      cityName: json['name'],
      country: json['sys']['country'],
    );
  }
}

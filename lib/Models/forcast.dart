import 'daily.dart';
import 'hourly.dart';

class Forecast {
  final List<HourlyWeatherResponce> hourly;
  final List<DailyWeatherResponce> daily;

  Forecast({required this.hourly, required this.daily});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    List<dynamic> hourlyData = json['hourly'];
    List<dynamic> dailyData = json['daily'];

    List<HourlyWeatherResponce> hourly = [];
    List<DailyWeatherResponce> daily = [];

    hourlyData.forEach((item) {
      var hour = HourlyWeatherResponce.fromJson(item);
      hourly.add(hour);
    });

    dailyData.forEach((item) {
      var day = DailyWeatherResponce.fromJson(item);
      daily.add(day);
    });

    return Forecast(hourly: hourly, daily: daily);
  }
}

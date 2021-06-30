import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_flutter/Models/forcast.dart';

import 'weather.dart';

class ResponceHandeller {
  final appid = 'fe94c2f499c95c8b08556f197b6b54bd';

  Future<Weather> getWeatherByCordination(
      String latitude, String longitude) async {
    final queryParameters = {
      'lat': latitude,
      'lon': longitude,
      'appid': appid,
      'units': 'metric'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final responce = await http.get(uri);

    final json = jsonDecode(responce.body);
    return Weather.fromJson(json);
  }

  Future<Weather> getWeatherByCity(String city) async {
    final queryParameters = {
      'q': city,
      'appid': appid,
      'units': 'metric',
      'lang': 'en'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final responce = await http.get(uri);

    final json = jsonDecode(responce.body);
    return Weather.fromJson(json);
  }

  Future<Forecast> getWeatherForecast(String latitude, String longitude) async {
    final queryParameters = {
      'lat': latitude,
      'lon': longitude,
      'appid': appid,
      'exclude': 'minutely',
      'units': 'metric'
    };
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/onecall', queryParameters);

    final responce = await http.get(uri);

    final json = jsonDecode(responce.body);
    return Forecast.fromJson(json);
  }
}

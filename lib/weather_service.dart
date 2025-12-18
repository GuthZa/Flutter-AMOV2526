import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_forecast.dart';

class WeatherService {
  static const _url =
      'https://api.ipma.pt/open-data/forecast/meteorology/cities/daily/3460200.json';

  Future<WeatherForecastResponse> fetchForecast() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      return WeatherForecastResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

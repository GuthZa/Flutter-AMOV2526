import 'package:flutter/material.dart';
import 'package:flutter_amov2526/models/weather_forecast.dart';
import 'package:flutter_amov2526/services/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<WeatherForecastResponse> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = WeatherService().fetchForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(child: Image.asset('images/Coimbra.jpg', fit: BoxFit.fill)),
      ],
    );
  }
}

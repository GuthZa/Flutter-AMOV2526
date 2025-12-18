import 'package:flutter/material.dart';
import 'package:flutter_amov2526/weather_forecast.dart';
import 'package:flutter_amov2526/weather_service.dart';

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
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 256, child: Image.asset('images/Coimbra.jpg')),
            ],
          ),
          Row(
            children: [

            ],
          ),
        ],
      ),
    );
  }
}

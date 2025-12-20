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
    return Container(
      width: 500,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/coimbra.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withValues(alpha: 0.4),
          child: FutureBuilder<WeatherForecastResponse>(
            future: _weatherFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(color: Colors.white);
              } else if (snapshot.hasError) {
                return const Text(
                  'Erro ao obter o estado do tempo',
                  style: TextStyle(color: Colors.white),
                );
              } else {
                final weather = snapshot.data!;
                final textStyle = const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                );
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Coimbra',
                      style: textStyle),
                    const SizedBox(height: 12),
                    Text(
                      '${weather.data.first.tMax} °C',
                      style: textStyle,
                    )
                  ],
                );
              }
            },
          ),
        )
    );
  }
}

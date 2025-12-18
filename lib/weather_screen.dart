import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'weather_service.dart';
import 'weather_forecast.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = WeatherService();

    return Scaffold(
      appBar: AppBar(title: const Text('5-Day Weather Forecast')),
      body: FutureBuilder<WeatherForecastResponse>(
        future: service.fetchForecast(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final forecast = snapshot.data!.data;

          return ListView.builder(
            itemCount: forecast.length,
            itemBuilder: (context, index) {
              final day = forecast[index];
              final date =
              DateFormat('EEE, MMM d').format(DateTime.parse(day.forecastDate));

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.cloud),
                  title: Text(date),
                  subtitle: Text(
                    'Min: ${day.tMin}°C  |  Max: ${day.tMax}°C\n'
                        'Rain: ${day.precipitaProb.toStringAsFixed(0)}%  |  Wind: ${day.windDir}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

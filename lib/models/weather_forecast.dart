class WeatherForecastResponse {
  final List<DailyForecast> data;
  final String dataUpdate;

  WeatherForecastResponse({required this.data, required this.dataUpdate});

  factory WeatherForecastResponse.fromJson(Map<String, dynamic> json) {
    return WeatherForecastResponse(
      data: (json['data'] as List)
          .map((e) => DailyForecast.fromJson(e))
          .toList(),
      dataUpdate: json['dataUpdate'],
    );
  }
}

class DailyForecast {
  final String forecastDate;
  final double tMin;
  final double tMax;
  final double precipitaProb;
  final String windDir;
  final int weatherType;

  DailyForecast({
    required this.forecastDate,
    required this.tMin,
    required this.tMax,
    required this.precipitaProb,
    required this.windDir,
    required this.weatherType,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      forecastDate: json['forecastDate'],
      tMin: double.parse(json['tMin']),
      tMax: double.parse(json['tMax']),
      precipitaProb: double.parse(json['precipitaProb']),
      windDir: json['predWindDir'],
      weatherType: json['idWeatherType'],
    );
  }

  final List<String> descWeatherTypePT = [
    'Sem informação',
    'Céu limpo',
    'Céu pouco nublado',
    'Céu parcialmente nublado',
    'Céu muito nublado ou encoberto',
    'Céu nublado por nuvens altas',
    'Aguaceiros/chuva',
    'Aguaceiros/chuva fracos',
    'Aguaceiros/chuva fortes',
    'Chuva/aguaceiros',
    'Chuva fraca ou chuvisco',
    'Chuva/aguaceiros forte',
    'Períodos de chuva',
    'Períodos de chuva fraca',
    'Períodos de chuva forte',
    'Chuvisco',
    'Neblina',
    'Nevoeiro ou nuvens baixas',
    'Neve',
    'Trovoada',
    'Aguaceiros e possibilidade de trovoada',
    'Granizo',
    'Geada',
    'Chuva e possibilidade de trovoada',
    'Nebulosidade convectiva',
    'Céu com períodos de muito nublado',
    'Nevoeiro',
    'Céu nublado',
    'Aguaceiros de neve',
    'Chuva e Neve',
    'Chuva e Neve',
  ];

  String weatherTypeName(int type) {
    var weatherTypes = ["Sem informação"];
    return descWeatherTypePT[0];
  }
}

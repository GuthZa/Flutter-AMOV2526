import 'package:flutter/material.dart';
import 'package:flutter_amov2526/weather_forecast.dart';
import 'package:flutter_amov2526/weather_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'categorypage.dart';
import 'homepage.dart';
import 'navbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Future<void> initInc() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   setState (() { _inc = prefs.getInt('increment') ?? 1; } );
  // }
  //
  // Future<void> changeInc(int inc) async {
  //   setState (() { _inc = inc; } );
  //   var prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('increment', _inc);
  // }

  void testData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save an integer value to 'counter' key.
    await prefs.setInt('counter', 10);
    // Save an boolean value to 'repeat' key.
    await prefs.setBool('repeat', true);
    // Save an double value to 'decimal' key.
    await prefs.setDouble('decimal', 1.5);
    // Save an String value to 'action' key.
    await prefs.setString('action', 'Start');
    // Save an list of strings to 'items' key.
    await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);

    // Try reading data from the 'counter' key. If it doesn't exist, returns null.
    final int? counter = prefs.getInt('counter');
    // Try reading data from the 'repeat' key. If it doesn't exist, returns null.
    final bool? repeat = prefs.getBool('repeat');
    // Try reading data from the 'decimal' key. If it doesn't exist, returns null.
    final double? decimal = prefs.getDouble('decimal');
    // Try reading data from the 'action' key. If it doesn't exist, returns null.
    final String? action = prefs.getString('action');
    // Try reading data from the 'items' key. If it doesn't exist, returns null.
    final List<String>? items = prefs.getStringList('items');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AMOV TP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const HomeScreen(title: 'Coimbra'),
      initialRoute: "/",
      routes: {"/Category": (context) => const CategoryScreen()},
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = <Widget>[
    const HomePage(),
    const CategoryScreen(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late Future<WeatherForecastResponse> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = WeatherService().fetchForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              FutureBuilder(
                future: _weatherFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Erro ao obter o estado do tempo');
                  } else {
                    final weather = snapshot.data!;
                    return Row(
                      children: [
                        Text(
                          '${weather.data.first.tMax} ºC',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        WeatherIcon(weatherId: weather.data.first.weatherType),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: NavBar(index: _selectedIndex, onTap: _onItemTapped),
    );
  }
}

class WeatherIcon extends StatelessWidget {
  WeatherIcon({super.key, required this.weatherId});

  final int weatherId;

  late final String _url = weatherId >= 10
      ? 'images/icons_ipma_weather/w_ic_d_$weatherId.svg'
      : 'images/icons_ipma_weather/w_ic_d_0$weatherId.svg';

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(_url, width: 65);
  }
}

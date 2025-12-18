import 'package:flutter/material.dart';
import 'package:flutter_amov2526/weather_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          const Text('Coimbra'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 256, child: Image.asset('images/Coimbra.jpg')),

            ],
          ),
        ],
      ),
    );
  }
}
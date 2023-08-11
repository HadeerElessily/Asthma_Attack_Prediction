import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: implementation_imports, unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
// ignore: unused_import, implementation_imports
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:asthma/pages/welcome_page.dart';

import '../pages/weather_screen.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Map<String, dynamic> weatherData = {};

  Future<void> fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        'http://api.airvisual.com/v2/nearest_city?lat=31.197730&lon=29.892540&key=739ab98b-759c-4760-a568-dc192fa26832'));
    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
        primaryColor: Color.fromARGB(255, 6, 38, 64),
    colorScheme: Theme.of(context).colorScheme.copyWith(
    secondary: Color.fromARGB(255, 9, 163, 235),
    ),
    fontFamily: 'Roboto',
    ),
    home: Scaffold(
    body: weatherData.isEmpty
    ? Center(child: CircularProgressIndicator())
        : Stack(
    children: [
    Image.asset(
    'assets/images/2.jpg', // Replace with your image path
    fit: BoxFit.cover,
    width: double.infinity,
    height: double.infinity,
    ),
    SingleChildScrollView(
    child: WeatherScreen(weatherData: weatherData),
    ),
    ],
    ),floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.home),
    ),
    ),);
  }
}

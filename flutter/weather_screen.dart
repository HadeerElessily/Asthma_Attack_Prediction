import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

//import 'package:flutter/src/widgets/placeholder.dart';
//import 'dart:convert';

class WeatherScreen extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const WeatherScreen({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final currentWeather = weatherData['current']['weather'];
    final airQuality = weatherData['current']['pollution'];
    bool isGoodAirQuality = airQuality['aqius'] <= 50;

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SafeArea(
            child: Text(
              '${weatherData['city']}, ${weatherData['state']}, ${weatherData['country']}',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            children: [
              buildInfoCard(
                'Temperature',
                '${currentWeather['tp']}°C',
                Icons.thermostat,
              ),
              buildInfoCard(
                'Pressure',
                '${currentWeather['pr']}',
                Icons.trending_up,
              ),
              buildInfoCard(
                'Humidity',
                '${currentWeather['hu']}%',
                Icons.opacity,
              ),
              buildInfoCard(
                'Wind Speed',
                '${currentWeather['ws']} km/h',
                Icons.air,
              ),
              buildAirQualityCard(
                'Air Quality Index (US)',
                airQuality['aqius'],
                Icons.air,
              ),
              buildAirQualityCard(
                'Air Quality Index (China)',
                airQuality['aqicn'],
                Icons.air,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            color: Colors.yellow.withOpacity(0.6),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                isGoodAirQuality ? "It looks nice to take a walk" : "You should stay at home",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildInfoCard(String title, String value, IconData iconData) {
    return Card(
      color: Colors.white.withOpacity(0.6),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(iconData),
                const SizedBox(width: 8.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              value,
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAirQualityCard(String title, int value, IconData iconData) {
    Color cardColor;
    String airQualityStatus;

    if (value <= 50) {
      cardColor = Colors.green.withOpacity(0.6);
      airQualityStatus = 'Good';
    } else if (value <= 100) {
      cardColor = Colors.yellow.withOpacity(0.6);
      airQualityStatus = 'Moderate';
    } else {
      cardColor = Colors.red.withOpacity(0.6);
      airQualityStatus = 'Poor';
    }

    return Card(
      color: cardColor,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(iconData, color: Colors.white),
                const SizedBox(width: 8.0),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      value.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      airQualityStatus,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

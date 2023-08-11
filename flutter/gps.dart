import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:url_launcher/url_launcher.dart';

import '../navigator/bottom_navigator.dart';

class NearestHospitalsScreen extends StatefulWidget {
  const NearestHospitalsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NearestHospitalsScreenState createState() => _NearestHospitalsScreenState();
}

class _NearestHospitalsScreenState extends State<NearestHospitalsScreen> {
  final GoogleMapsPlaces _places =
  GoogleMapsPlaces(apiKey: 'AIzaSyDMsXQB13uezRITknL1v1LyahcRAQd6hxc');
  LatLng? _currentPosition;
  List<PlacesSearchResult> _nearbyHospitals = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    _getNearbyHospitals();
  }

  Future<void> _getNearbyHospitals() async {
    final location = _currentPosition != null
        ? Location(
      lat: _currentPosition!.latitude,
      lng: _currentPosition!.longitude,
    )
        : null;

    if (location != null) {
      final response = await _places.searchNearbyWithRadius(
        location,
        1000, // Radius in meters
        type: 'hospital',
      );

      setState(() {
        _nearbyHospitals = response.results;
      });
    }
  }

  Future<void> _getPlaceDetails(String placeId) async {
    final response = await _places.getDetailsByPlaceId(placeId);
    if (response.status == "OK") {
      final result = response.result;
      // ignore: unnecessary_null_comparison
      if (result != null) {
        final phoneNumber = result.formattedPhoneNumber;
        if (phoneNumber != null) {
          final url = 'tel:$phoneNumber';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text('Failed to open the dialer.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              ),
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Phone Number'),
              content: Text('Phone number not available.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearest Hospitals'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Places: ${_nearbyHospitals.length}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _nearbyHospitals.length,
              itemBuilder: (context, index) {
                final hospital = _nearbyHospitals[index];
                return Card(
                  child: ListTile(
                    title: Text(hospital.name),
                    subtitle: Text(hospital.vicinity ?? ''),
                    onTap: () {
                      _getPlaceDetails(hospital.placeId);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.home),
      ),);

  }
}


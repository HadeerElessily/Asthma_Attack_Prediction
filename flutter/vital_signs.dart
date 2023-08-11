import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:asthma/navigator/bottom_navigator.dart';

class VitalSignsScreen extends StatefulWidget {
  const VitalSignsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VitalSignsScreenState createState() => _VitalSignsScreenState();
}

class _VitalSignsScreenState extends State<VitalSignsScreen> {
  TextEditingController heartRateController = TextEditingController();
  TextEditingController bloodPressureController = TextEditingController();
  TextEditingController oxygenRateController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  String heartRate = '';
  String bloodPressure = '';
  String oxygenRate = '';
  String heartRateMessage = '';
  String bloodPressureMessage = '';
  String oxygenRateMessage = '';

  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    // Set the initial value of the date text field
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    dateController.text = formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vital Signs'),
      ),floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.home),
    ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: dateController,
                enabled: false, // Disable user input
                decoration: const InputDecoration(labelText: 'Date'),
              ),
              TextField(
                controller: heartRateController,
                decoration: const InputDecoration(labelText: 'Heart Rate'),
              ),
              TextField(
                controller: bloodPressureController,
                decoration: const InputDecoration(labelText: 'Blood Pressure'),
              ),
              TextField(
                controller: oxygenRateController,
                decoration: const InputDecoration(labelText: 'Oxygen Rate'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    heartRate = heartRateController.text;
                    bloodPressure = bloodPressureController.text;
                    oxygenRate = oxygenRateController.text;

                    int? heartRateValue = int.tryParse(heartRate);
                    if (heartRateValue != null) {
                      if (heartRateValue > 100) {
                        heartRateMessage = 'Tachycardia! (HIGH)';
                      } else if (heartRateValue < 60) {
                        heartRateMessage = 'Bradycardia! (LOW)';
                      } else {
                        heartRateMessage = 'You are normal';
                      }
                    } else {
                      heartRateMessage = '';
                    }

                    String systolicPressure = bloodPressure.split('/')[0];
                    String diastolicPressure = bloodPressure.split('/')[1];
                    int? systolicValue = int.tryParse(systolicPressure);
                    int? diastolicValue = int.tryParse(diastolicPressure);
                    if (systolicValue != null && diastolicValue != null) {
                      if (systolicValue > 120 || diastolicValue < 80) {
                        bloodPressureMessage = 'Hypertension! (High)';
                      } else if (systolicValue == 120 && diastolicValue == 80) {
                        bloodPressureMessage = 'Your blood pressure is normal';
                      } else {
                        bloodPressureMessage = 'Hypotension! (LOW)';
                      }
                    } else {
                      bloodPressureMessage = '';
                    }

                    double? oxygen = double.tryParse(oxygenRate);
                    if (oxygen != null) {
                      if (oxygen >= 90 && oxygen <= 95) {
                        oxygenRateMessage = 'You are safe!';
                      } else if (oxygen >= 70 && oxygen < 90) {
                        oxygenRateMessage = 'you need to use a ventilator!!';
                      } else if (oxygen < 70) {
                        oxygenRateMessage = 'You are in danger!';
                      } else {
                        oxygenRateMessage = '';
                      }
                    } else {
                      oxygenRateMessage = '';
                    }
                  });
                },
                child: const Text('Save'),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Heart Rate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                heartRate,
                style: TextStyle(
                  fontSize: 18.0,
                  color: (heartRateMessage == 'You are normal')
                      ? Colors.green
                      : Colors.red,
                ),
              ),
              const SizedBox(height: 4.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                color: (heartRateMessage == 'You are normal')
                    ? Colors.green.withOpacity(0.3)
                    : Colors.red.withOpacity(0.3),
                child: Text(
                  heartRateMessage,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: (heartRateMessage == 'You are normal')
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Blood Pressure',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                bloodPressure,
                style: TextStyle(
                  fontSize: 18.0,
                  color:
                      (bloodPressureMessage == 'Your blood pressure is normal')
                          ? Colors.green
                          : Colors.red,
                ),
              ),
              const SizedBox(height: 4.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                color: (bloodPressureMessage == 'Your blood pressure is normal')
                    ? Colors.green.withOpacity(0.3)
                    : Colors.red.withOpacity(0.3),
                child: Text(
                  bloodPressureMessage,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: (bloodPressureMessage ==
                            'Your blood pressure is normal')
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Oxygen Rate',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                oxygenRate,
                style: TextStyle(
                  fontSize: 18.0,
                  color: (oxygenRateMessage == 'You are safe!')
                      ? Colors.green
                      : (oxygenRateMessage == 'you need to use a ventilator!')
                          ? Colors.yellow
                          : Colors.red,
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                color: (oxygenRateMessage == 'You are safe!')
                    ? Colors.green.withOpacity(0.3)
                    : (oxygenRateMessage == 'you need to use a ventilator!')
                        ? Colors.yellow.withOpacity(0.3)
                        : Colors.red.withOpacity(0.3),
                child: Text(
                  oxygenRateMessage,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: (oxygenRateMessage == 'You are safe!')
                        ? Colors.green
                        : (oxygenRateMessage == 'you need to use a ventilator!')
                            ? Colors.yellow
                            : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
     /* bottomNavigationBar: BottomNavigator(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),*/
    );
  }
}

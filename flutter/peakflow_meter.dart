import 'package:asthma/features/home.dart';
import 'package:asthma/navigator/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:asthma/main.dart';



class PeakFlowMeter extends StatefulWidget {
  const PeakFlowMeter({super.key});

  @override
  State<PeakFlowMeter> createState() => _PeakFlowMeterState();
}

class _PeakFlowMeterState extends State<PeakFlowMeter> {
  final List<Reading> readings = [];

  final _formKey = GlobalKey<FormState>();
  final readingController = TextEditingController();

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        final now = DateTime.now();
        final date =
            '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
        readings.add(Reading(date, int.parse(readingController.text)));
      });
      readingController.clear();
    }
  }

  String getMessage(int reading) {
    if (reading >= 80 && reading <= 100) {
      return 'You are in safe.';
    } else if (reading >= 50 && reading < 80) {
      return 'Take action.';
    } else if (reading < 50) {
      return 'You are in danger.';
    }
    return '';
  }

  Color getColor(int reading) {
    switch (reading) {
      case 0:
        return Colors.transparent;
      case 1:
        return Colors.red;
      case 2:
        return Colors.deepOrange;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.yellow;
      case 5:
        return Colors.green;
      case 6:
        return Colors.lightGreen;
      default:
        return Colors.grey;
    }
  }

  int getReadingColorIndex(int reading) {
    if (reading >= 80 && reading <= 100) {
      return 5;
    } else if (reading >= 50 && reading < 80) {
      return 4;
    } else if (reading < 50) {
      return 1;
    }
    return 0;
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peak Flow Meter'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                )); // Navigate back to the homepage
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your peak flow reading:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    readOnly: true,
                    initialValue:
                        '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: readingController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a reading';
                      }
                      final intReading = int.tryParse(value);
                      if (intReading == null) {
                        return 'Please enter a valid reading';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Reading',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: submitForm,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Readings:'),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: readings.length,
                itemBuilder: (context, index) {
                  final reading = readings[index];
                  final message = getMessage(reading.reading);
                  final color = getColor(getReadingColorIndex(reading.reading));
                  return Card(
                    child: ListTile(
                      title: Text(reading.date),
                      subtitle: Text('${reading.reading}'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          message,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
     /* bottomNavigationBar: BottomNavigator(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.home),
      ),
    );
  }
}

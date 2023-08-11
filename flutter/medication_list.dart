import 'package:asthma/features/home.dart';
import 'package:asthma/main.dart';
import 'package:asthma/features/medication_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../navigator/bottom_navigator.dart';


class MedicationList extends StatefulWidget {
  const MedicationList({super.key});

  @override
  State<MedicationList> createState() => _MedicationListState();
}

class _MedicationListState extends State<MedicationList> {
  final List<Medication> _medications = [];

  void _addMedication() async {
    final medication = await Navigator.push<Medication>(
      context,
      MaterialPageRoute(
        builder: (context) => const MedicationForm(),
      ),
    );
    if (medication != null) {
      setState(() {
        _medications.add(medication);
      });
    }
  }

  //int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medication Reminder List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                )); // Navigate back to the homepage
          },
        ),actions: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
            // Navigate to the home page
          },
        ),
      ],
      ),
      body: ListView.builder(
        itemCount: _medications.length,
        itemBuilder: (context, index) {
          final medication = _medications[index];
          return ListTile(
            title: Text(medication.name),
            subtitle: Text(
                '${medication.dosage} ml at ${medication.time.format(context)} on ${medication.date.toString().substring(0, 10)}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMedication,
        child: const Icon(Icons.add),

      ),
      /*bottomNavigationBar: BottomNavigator(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),*/
    );
  }
}

Future<void> scheduleNotification(Medication medication) async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Convert the TimeOfDay to a DateTime
  final now = DateTime.now();
  final futureDate =
      now.add(const Duration(days: 1)); // Add 1 day to the current date
  final scheduledDate = tz.TZDateTime.from(
    futureDate,
    tz.local,
  );

  // final scheduledDate = DateTime(now.year, now.month, now.day,
  //   medication.time.hour, medication.time.minute);

  // Schedule the notification
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'Medication Reminder',
    'It\'s time to take ${medication.name} (${medication.dosage} ml)',
    tz.TZDateTime.from(scheduledDate, tz.local),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_name',
        'channel_description',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    // ignore: deprecated_member_use
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

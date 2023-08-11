import 'package:asthma/features/medication_list.dart';
import 'package:asthma/features/peakflow_meter.dart';
//import 'package:asthma/features/profile.dart';
//import 'package:asthma/features/sos_button.dart';
import 'package:asthma/features/vital_signs.dart';
import 'package:asthma/pages/login_page.dart';
import 'package:asthma/pages/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../navigator/bottom_navigator.dart';
//import '../navigator/boxdetails.dart';
import 'asthma_form.dart';
import 'awareness_protocol.dart';
import 'gps.dart';
import 'weather.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: const [
          BoxItem(
            title: 'Weather',
            image: 'assets/images/cloud-in-blue-sky.jpg',
            details: 'Details for Weather',
            page: Weather(),
          ),
          BoxItem(
            title: 'Nearest Hospitals',
            image: 'assets/images/location.jpg',
            details: 'Details for hospitals location',
            page: NearestHospitalsScreen(), // Specify the page to navigate to
          ),
          BoxItem(
            title: 'Peak Flow Meter',
            image: 'assets/images/peak.jpg',
            details: 'Details for Peak Flow',
            page: PeakFlowMeter(), // Specify the page to navigate to
          ),
          BoxItem(
            title: 'Vital Signs',
            image: 'assets/images/vitalsigns.jpg',
            details: 'Details for Vital Signs',
            page: VitalSignsScreen(), // Specify the page to navigate to
          ),
          BoxItem(
            title: 'Medication',
            image: 'assets/images/medics.jpg',
            details: 'Details for Medication',
            page: MedicationList(), // Specify the page to navigate to
          ),
          BoxItem(
            title: 'Symptom Checker',
            image: 'assets/images/checker.jpg',
            details: 'Symptoms Checker',
            page: AsthmaForm(), // Specify the page to navigate to
          ),
          BoxItem(
            title: 'Awareness Protocol',
            image: 'assets/images/awareness.jpg',
            details: 'Details for Awareness',
            page: AwarenessProtocol(), // Specify the page to navigate to
          ),
          BoxItem(
            title: 'Log Out',
            image: 'assets/images/logout.png',
            details: 'Details for Awareness',
            page: WelcomePage(), // Specify the page to navigate to
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigator(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
      /*floatingActionButton: ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          child: const Text(
            'Log Out',
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),*/
    );
  }
}

class BoxItem extends StatelessWidget {
  final String title;
  final String image;
  final String details;
  final Widget page; // The page to navigate to

  const BoxItem({
    Key? key,
    required this.title,
    required this.image,
    required this.details,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/*class ItemDashboard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color background;
  final VoidCallback onTap;

  const ItemDashboard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.background,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                imagePath,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}*/

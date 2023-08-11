import 'package:asthma/features/home.dart';
import 'package:asthma/navigator/bottom_navigator.dart';
import 'package:asthma/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                )); // Navigate back to the homepage
          },
        ),
      ),
      body: const Center(
          child: Text(
        'Profile',
        style: TextStyle(fontSize: 40),
      )),
      floatingActionButton: ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          child: const Text(
            'Log Out',
            style: TextStyle(fontSize: 18, color: Colors.white),
          )),
      bottomNavigationBar: BottomNavigator(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
    );
  }
}

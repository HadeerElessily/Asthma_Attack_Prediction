// ignore_for_file: avoid_print, duplicate_ignore
import 'dart:async';
import 'package:asthma/features/home.dart';
import 'package:asthma/navigator/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class SosButton extends StatefulWidget {
  const SosButton({super.key});

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton> {
  bool isCalling = false;
  int countdown = 5;
  late Timer timer = Timer(Duration.zero, () {});

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          timer.cancel();
          makeEmergencyCall();
        }
      });
    });
  }

  void makeEmergencyCall() async {
    const phoneNumber = '123';
    bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    if (res != null && res) {
      // ignore: avoid_print
      print('Simulated emergency call to $phoneNumber');
    } else {
      print('Failed to initiate simulated call');
    }
  }

  void cancelCall() {
    timer.cancel();
    setState(() {
      countdown = 5;
      isCalling = false;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Call'),
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
      ),floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(),
            ));
      },
      child: Icon(Icons.home),
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sending an emergency call',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            if (isCalling)
              Text(
                'Calling 123 in $countdown seconds',
                style: const TextStyle(fontSize: 18),
              ),
            const SizedBox(height: 20),
            if (!isCalling)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isCalling = true;
                  });
                  startTimer();
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(30),
                ),
                child: const Icon(
                  Icons.add_call,
                  size: 50,
                  color: Colors.red, // Set the color of the SOS icon to red
                ),
              ),
            if (isCalling)
              ElevatedButton(
                onPressed: cancelCall,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'Cancel Call',
                  style: TextStyle(fontSize: 18),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigator(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
    );
  }
}

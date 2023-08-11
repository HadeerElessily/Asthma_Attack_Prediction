import 'package:flutter/material.dart';
import 'package:asthma/features/home.dart';
import 'package:asthma/features/profile.dart';
import 'package:asthma/features/sos_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    const Home(),
    const SosButton(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentIndex == 0
          ? AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              radius: 16,
              backgroundImage:
              AssetImage('assets/images/difficulty-breathing.png'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      )
          : null,
      body: Stack(
        children: [
          IndexedStack(
            index: currentIndex,
            children: screens,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigationBar(
              iconSize: 30,
              selectedFontSize: 15,
              unselectedFontSize: 12,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: (index) => setState(() => currentIndex = index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.blue,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.emergency_outlined),
                  label: 'SOS',
                  backgroundColor: Colors.blue,
                ),
              ],
              showSelectedLabels: true,
            ),
          ),
        ],
      ),
    );
  }
}

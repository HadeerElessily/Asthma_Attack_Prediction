import 'package:flutter/material.dart';

class BottomNavigator extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavigator({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: 30,
      selectedFontSize: 15,
      unselectedFontSize: 12,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.blue,
        ),
        /*BottomNavigationBarItem(
          icon: Icon(Icons.data_usage_outlined),
          label: 'Peakflow Meter',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Vital Signs',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tips_and_updates),
          label: 'Meds Reminder',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emergency_outlined),
          label: 'Awareness Protocol',
          backgroundColor: Colors.blue,
        ),*/
        BottomNavigationBarItem(
          icon: Icon(Icons.emergency_outlined),
          label: 'SOS',
          backgroundColor: Colors.blue,

        ),
      ],
      showSelectedLabels: true,
    );
  }
}

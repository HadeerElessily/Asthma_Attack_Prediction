import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoxDetailsPage extends StatelessWidget {
  final String title;
  final String details;

  const BoxDetailsPage({super.key, required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          details,
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
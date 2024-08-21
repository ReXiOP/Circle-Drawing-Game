import 'package:flutter/material.dart';
import 'landing_page.dart';

void main() {
  runApp(CircleDrawingGame());
}

class CircleDrawingGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circle Drawing Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,  // For a dark theme
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(),  // Starting with the Landing Page
    );
  }
}

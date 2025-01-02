import 'package:flutter/material.dart';
import 'package:prayer/screens/home.dart';
import 'package:prayer/screens/qibla_direction.dart';
import 'package:prayer/screens/settings_screen.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        "/home": (context) => Home(),
        "/qibla": (context) => QiblaDirection(),
        "/settings": (context) => Settings(),
      }
    );
  }
}

import 'package:flutter/material.dart';
import 'views/main_screen.dart';

void main() {
  runApp(const PlantOrganizerApp());
}

class PlantOrganizerApp extends StatelessWidget {
  const PlantOrganizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Organizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

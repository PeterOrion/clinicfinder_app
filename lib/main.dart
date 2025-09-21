// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/map_screen.dart';
import 'screens/clinic_detail_screen.dart';
import 'models/clinic.dart';

void main() {
  runApp(const ClinicFinderApp());
}

class ClinicFinderApp extends StatelessWidget {
  const ClinicFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinic Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/map': (context) => const MapScreen(),
      },
      // Handle dynamic routes like ClinicDetailScreen with arguments
      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final clinic = settings.arguments as Clinic;
          return MaterialPageRoute(
            builder: (context) => ClinicDetailScreen(clinic: clinic),
          );
        }
        return null;
      },
    );
  }
}

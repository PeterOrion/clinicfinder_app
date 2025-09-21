import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/clinic.dart';
import '../widgets/clinic_card.dart';
import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Clinic> clinics = [];

  @override
  void initState() {
    super.initState();
    loadClinics();
  }

  Future<void> loadClinics() async {
    final String response = await rootBundle.loadString('assets/clinics.json');
    final List<dynamic> data = jsonDecode(response);
    setState(() {
      clinics = data.map((json) => Clinic.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinic Finder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MapScreen(clinics: clinics),
                ),
              );
            },
          )
        ],
      ),
      body: clinics.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: clinics.length,
              itemBuilder: (context, index) {
                return ClinicCard(clinic: clinics[index]);
              },
            ),
    );
  }
}

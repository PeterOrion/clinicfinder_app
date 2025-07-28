import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/clinic.dart';
import '../widgets/clinic_card.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Clinic> allClinics = [];
  String selectedFilter = 'All';
  String searchQuery = '';
  final List<String> filters = ['All', 'Free', 'Affordable'];

  @override
  void initState() {
    super.initState();
    loadClinics();
  }

  Future<void> loadClinics() async {
    final String response = await rootBundle.loadString('assets/clinics.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      allClinics = data.map((clinic) => Clinic.fromJson(clinic)).toList();
    });
  }

  List<Clinic> get filteredClinics {
    List<Clinic> filtered = List.from(allClinics);

    if (selectedFilter == 'Free') {
      filtered = filtered.where((c) => c.price.toLowerCase() == 'free').toList();
    } else if (selectedFilter == 'Affordable') {
      filtered = filtered.where((c) {
        if (c.price.toLowerCase() == 'free') return true;
        final amount = int.tryParse(c.price.replaceAll(RegExp(r'[^\d]'), '')) ?? 9999;
        return amount <= 1000;
      }).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((c) => c.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clinic Finder')),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search clinics...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          // 🔽 Filter Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Text(
                  'Filter by:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedFilter,
                  items: filters.map((filter) {
                    return DropdownMenuItem<String>(
                      value: filter,
                      child: Text(filter),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedFilter = value;
                      });
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 📋 Clinic List or Empty Message
          Expanded(
            child: filteredClinics.isEmpty
                ? const Center(
                    child: Text(
                      'No clinics found.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredClinics.length,
                    itemBuilder: (context, index) {
                      return ClinicCard(clinic: filteredClinics[index]);
                    },
                  ),
          ),
        ],
      ),

      // 🗺️ Floating Map Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/map');
        },
        tooltip: 'View on Map',
        child: const Icon(Icons.map),
      ),
    );
  }
}

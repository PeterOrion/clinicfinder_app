import 'package:flutter/material.dart';
import '../models/clinic.dart';
import '../widgets/clinic_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample hardcoded clinics
  final List<Clinic> allClinics = [
    Clinic(
      name: 'Hope Medical Center',
      address: 'Kahawa West, Nairobi',
      price: 'Free',
      rating: 4.5,
    ),
    Clinic(
      name: 'Sunrise Clinic',
      address: 'Githurai 45',
      price: 'KES 500',
      rating: 4.0,
    ),
    Clinic(
      name: 'Healing Hands Hospital',
      address: 'Zimmerman',
      price: 'KES 800',
      rating: 3.8,
    ),
    Clinic(
      name: 'Primecare Nairobi',
      address: 'Thika Road',
      price: 'KES 1500',
      rating: 4.2,
    ),
  ];

  String selectedFilter = 'All';
  String searchQuery = '';
  final List<String> filters = ['All', 'Free', 'Affordable'];

  // Filter logic
  List<Clinic> get filteredClinics {
    List<Clinic> filtered = List.from(allClinics);

    // Filter by price
    if (selectedFilter == 'Free') {
      filtered = filtered
          .where((c) => c.price.toLowerCase() == 'free')
          .toList();
    } else if (selectedFilter == 'Affordable') {
      filtered = filtered.where((c) {
        if (c.price.toLowerCase() == 'free') return true;
        final amount =
            int.tryParse(c.price.replaceAll(RegExp(r'[^\d]'), '')) ?? 9999;
        return amount <= 1000;
      }).toList();
    }

    // Filter by search
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (c) => c.name.toLowerCase().contains(searchQuery.toLowerCase()),
          )
          .toList();
    }

    return filtered;
  }

floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.pushNamed(context, '/map');
  },
  child: Icon(Icons.map),
  tooltip: 'View on Map',
),

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

          // 📋 Clinic List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredClinics.length,
              itemBuilder: (context, index) {
                return ClinicCard(clinic: filteredClinics[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

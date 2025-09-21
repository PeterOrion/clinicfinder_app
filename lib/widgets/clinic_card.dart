// lib/widgets/clinic_card.dart
import 'package:flutter/material.dart';
import '../models/clinic.dart';

class ClinicCard extends StatelessWidget {
  final Clinic clinic;

  const ClinicCard({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          // ✅ Navigate to ClinicDetailScreen instead of Map
          Navigator.pushNamed(
            context,
            '/detail',
            arguments: clinic,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                clinic.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(clinic.address),
              const SizedBox(height: 4),
              Text('Price: ${clinic.price}'),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(clinic.rating.toStringAsFixed(1)), // e.g., "4.3"
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

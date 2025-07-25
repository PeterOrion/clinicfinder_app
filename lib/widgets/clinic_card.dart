import 'package:flutter/material.dart';
import '../models/clinic.dart';

class ClinicCard extends StatelessWidget {
  final Clinic clinic;

  const ClinicCard({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: ListTile(
        title: Text(clinic.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${clinic.location}\n${clinic.contact}'),
        isThreeLine: true,
        leading: Icon(Icons.local_hospital, color: Colors.blue),
      ),
    );
  }
}

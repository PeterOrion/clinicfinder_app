// lib/widgets/clinic_card.dart

import 'package:flutter/material.dart';
import '../models/clinic.dart';

class ClinicCard extends StatelessWidget {
  final Clinic clinic;

  const ClinicCard({Key? key, required this.clinic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              clinic.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(clinic.address),
            SizedBox(height: 4),
            Text('Price: ${clinic.price}'),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                SizedBox(width: 4),
                Text(clinic.rating.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

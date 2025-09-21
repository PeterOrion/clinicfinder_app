import 'package:flutter/material.dart';
import '../models/clinic.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ClinicDetailScreen extends StatelessWidget {
  final Clinic clinic;

  const ClinicDetailScreen({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clinic.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🏥 Clinic Name
            Text(
              clinic.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // 📍 Address
            Text(
              clinic.address,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            // ⭐ Rating
            Row(
              children: [
                RatingBarIndicator(
                  rating: clinic.rating,
                  itemCount: 5,
                  itemSize: 24,
                  itemBuilder: (_, __) =>
                      const Icon(Icons.star, color: Colors.amber),
                ),
                const SizedBox(width: 10),
                Text('${clinic.rating} stars'),
              ],
            ),
            const SizedBox(height: 10),

            // 💵 Price
            Text(
              'Cost: ${clinic.price}',
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),
            const SizedBox(height: 30),

            const Divider(),

            // ℹ️ Extra Info (static for now, but you can expand later)
            Text(
              "Opening Hours: 8:00 AM - 5:00 PM",
              style: TextStyle(color: Colors.grey[700]),
            ),
            Text(
              "Contact: 0700 000 000",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

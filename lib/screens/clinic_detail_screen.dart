import 'package:flutter/material.dart';
import '../models/clinic.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ClinicDetailScreen extends StatelessWidget {
  final Clinic clinic;

  const ClinicDetailScreen({required this.clinic});

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
            Text(clinic.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(clinic.address, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Row(
              children: [
                RatingBarIndicator(
                  rating: clinic.rating,
                  itemCount: 5,
                  itemSize: 24,
                  itemBuilder: (_, __) => Icon(Icons.star, color: Colors.amber),
                ),
                SizedBox(width: 10),
                Text('${clinic.rating} stars'),
              ],
            ),
            SizedBox(height: 10),
            Text('Cost: ${clinic.price}',
                style: TextStyle(fontSize: 16, color: Colors.green)),
            SizedBox(height: 30),
            Divider(),
            Text("Opening Hours: 8:00 AM - 5:00 PM",
                style: TextStyle(color: Colors.grey[700])),
            Text("Contact: 0700 000 000",
                style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }
}

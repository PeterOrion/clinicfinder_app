import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/clinic.dart';

class MapScreen extends StatefulWidget {
  final List<Clinic> clinics;

  const MapScreen({super.key, required this.clinics});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _initialPosition = const LatLng(-1.2921, 36.8219); // Default: Nairobi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clinics Map"),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 12,
        ),
        markers: widget.clinics.map((clinic) {
          return Marker(
            markerId: MarkerId(clinic.name),
            position: LatLng(clinic.latitude, clinic.longitude),
            infoWindow: InfoWindow(
              title: clinic.name,
              snippet: "${clinic.address} - ${clinic.price}",
            ),
          );
        }).toSet(),
      ),
    );
  }
}

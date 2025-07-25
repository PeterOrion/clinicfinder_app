import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;

  final LatLng _initialPosition = const LatLng(
    -1.2101,
    36.8962,
  ); // Example: Kahawa West

  final List<Marker> _markers = [
    Marker(
      markerId: MarkerId('clinic1'),
      position: LatLng(-1.2101, 36.8962), // Kahawa West
      infoWindow: InfoWindow(title: 'Hope Medical Center'),
    ),
    Marker(
      markerId: MarkerId('clinic2'),
      position: LatLng(-1.2022, 36.9034), // Githurai 45
      infoWindow: InfoWindow(title: 'Sunrise Clinic'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clinics Map')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 13,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
        },
        markers: Set.from(_markers),
      ),
    );
  }
}

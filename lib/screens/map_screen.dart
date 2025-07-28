import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;

  final LatLng _initialPosition = const LatLng(-1.2101, 36.8962); // Kahawa West

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('clinic1'),
      position: LatLng(-1.2101, 36.8962),
      infoWindow: InfoWindow(title: 'Hope Medical Center'),
    ),
    Marker(
      markerId: MarkerId('clinic2'),
      position: LatLng(-1.2022, 36.9034),
      infoWindow: InfoWindow(title: 'Sunrise Clinic'),
    ),
  };

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

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
        markers: _markers,
      ),
    );
  }
}

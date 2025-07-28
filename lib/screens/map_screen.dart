import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/clinic.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final LatLng _initialPosition = const LatLng(-1.2101, 36.8962); // Kahawa West
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    loadClinicMarkers();
  }

  Future<void> loadClinicMarkers() async {
    final String jsonString = await rootBundle.loadString('assets/clinics.json');
    final List<dynamic> data = json.decode(jsonString);

    final clinics = data.map((clinic) => Clinic.fromJson(clinic)).toList();

    setState(() {
      _markers.addAll(clinics.map((clinic) {
        return Marker(
          markerId: MarkerId(clinic.name),
          position: LatLng(clinic.latitude, clinic.longitude),
          infoWindow: InfoWindow(title: clinic.name),
        );
      }));
    });
  }

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

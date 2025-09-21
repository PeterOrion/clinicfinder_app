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
    try {
      final String jsonString = await rootBundle.loadString('assets/clinics.json');
      final List<dynamic> data = json.decode(jsonString);
      final List<Clinic> clinics = data.map((clinic) => Clinic.fromJson(clinic)).toList();

      setState(() {
        _markers.addAll(clinics.map((clinic) {
          return Marker(
            markerId: MarkerId('${clinic.name}_${clinic.latitude}_${clinic.longitude}'),
            position: LatLng(clinic.latitude, clinic.longitude),
            infoWindow: InfoWindow(title: clinic.name),
          );
        }));
      });

      // Optional: Move camera to fit all markers
      if (_markers.isNotEmpty && _mapController != null) {
        final bounds = _markers.fold<LatLngBounds>(
          LatLngBounds(
            southwest: _markers.first.position,
            northeast: _markers.first.position,
          ),
          (bounds, marker) => bounds.including(marker.position),
        );
        _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
      }
    } catch (e) {
      debugPrint('Error loading clinics: $e');
    }
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

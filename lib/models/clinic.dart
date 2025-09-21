// lib/models/clinic.dart

class Clinic {
  final String name;
  final String address;
  final String price; // keep as String if you display "Free" or "$50"
  final double rating;
  final double latitude;
  final double longitude;

  Clinic({
    required this.name,
    required this.address,
    required this.price,
    required this.rating,
    required this.latitude,
    required this.longitude,
  });

  // Convert from JSON
  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      price: json['price'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }

  // Optional: Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'price': price,
      'rating': rating,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

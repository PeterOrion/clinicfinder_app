// lib/models/clinic.dart

class Clinic {
  final String name;
  final String address;
  final String price;
  final double rating;

  Clinic({
    required this.name,
    required this.address,
    required this.price,
    required this.rating,
  });

  // Optional: Add factory constructor if you'll use JSON data later
  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      price: json['price'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}

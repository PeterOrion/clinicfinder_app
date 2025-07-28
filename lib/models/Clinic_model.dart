class Clinic {
  final String name;
  final String address;
  final String price;
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

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      name: json['name'],
      address: json['address'],
      price: json['price'],
      rating: (json['rating'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}

class Clinic {
  final String name;
  final String location;
  final String contact;

  Clinic({
    required this.name,
    required this.location,
    required this.contact,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      name: json['name'],
      location: json['location'],
      contact: json['contact'],
    );
  }
}


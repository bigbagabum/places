class Place {
  final String id, name, placeType, description;
  final double lat, lon;
  final List<String> urls;

  Place(
      {required this.id,
      required this.name,
      required this.placeType,
      required this.description,
      required this.lat,
      required this.lon,
      required this.urls});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      placeType: json['placeType'],
      description: json['description'],
      lat: json['lat'].toDouble(),
      lon: json['lng'].toDouble(),
      urls: List<String>.from(json['urls']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'placeType': placeType,
      'description': description,
      'lat': lat,
      'lon': lon,
      'urls': urls,
    };
  }
}

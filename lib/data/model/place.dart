class Place {
  final String name, placeType, description;
  final double lat, lng;
  final List<String> urls;
  final int id;

//  final String name, url, details, type;
//   List<String> img;
//   final double lat, lan;
//   SightStatus status;
//   int sightId;

  Place(
      {required this.id,
      required this.name,
      required this.placeType,
      required this.description,
      required this.lat,
      required this.lng,
      required this.urls});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      placeType: json['placeType'],
      description: json['description'],
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
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
      'lng': lng,
      'urls': urls,
    };
  }
}

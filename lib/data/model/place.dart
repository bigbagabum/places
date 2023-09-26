import 'package:places/domain/sight.dart';

Sight? placeToString(Place place) {
  Sight? sight;

  // tempData[placeItem] = SightStatus.sightNoPlans;
  sight?.sightId = place.id;
  sight?.name = place.name;
  sight?.details = place.description;
  sight?.lat = place.lat;
  sight?.lng = place.lng;
  sight?.img = place.urls;
  sight?.type = place.placeType;
  sight?.status = SightStatus.sightNoPlans;

  return sight;
}

class Place {
  final String name, placeType, description;
  final double lat, lng;
  final List<String> urls;
  final int id;

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

import 'package:places/data/model/place.dart';

class PlaceDto extends Place {
  final double distance;

  PlaceDto({
    required String id,
    required String name,
    required String placeType,
    required String description,
    required double lat,
    required double lon,
    required List<String> urls,
    required this.distance, // Дополнительное поле distance
  }) : super(
          id: id,
          name: name,
          placeType: placeType,
          description: description,
          lat: lat,
          lon: lon,
          urls: urls,
        );

  // Метод toJson() для сериализации в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'placeType': placeType,
      'description': description,
      'lat': lat,
      'lon': lon,
      'urls': urls,
      'distance': distance, // Включаем distance в JSON
    };
  }

  // Метод fromJson() для десериализации из JSON
  factory PlaceDto.fromJson(Map<String, dynamic> json) {
    return PlaceDto(
      id: json['id'],
      name: json['name'],
      placeType: json['placeType'],
      description: json['description'],
      lat: json['lat'],
      lon: json['lon'],
      urls: List<String>.from(json['urls']),
      distance: json['distance'], // Извлекаем значение distance из JSON
    );
  }
}

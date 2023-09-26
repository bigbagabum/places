class PlaceDto {
  final String name, placeType, description;
  final double lat, lng, distance;
  final List<String> urls;
  final int id;

  PlaceDto({
    required this.id,
    required this.name,
    required this.placeType,
    required this.description,
    required this.lat,
    required this.lng,
    required this.urls,
    required this.distance, // Дополнительное поле distance
  });

  // Метод toJson() для сериализации в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'placeType': placeType,
      'description': description,
      'lat': lat,
      'lng': lng,
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
      lng: json['lng'],
      urls: List<String>.from(json['urls']),
      distance: json['distance'], // Извлекаем значение distance из JSON
    );
  }
}

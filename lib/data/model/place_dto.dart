class PlaceDto {
  final String id, name, placeType, description;
  final double lat, lon, distance;
  final List<String> urls;

  PlaceDto({
    required this.id,
    required this.name,
    required this.placeType,
    required this.description,
    required this.lat,
    required this.lon,
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

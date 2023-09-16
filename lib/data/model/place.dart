class Place {
  final String id, name, placeType, description;
  final double lat, lon;
  final List urls;

  Place(
      {required this.id,
      required this.name,
      required this.placeType,
      required this.description,
      required this.lat,
      required this.lon,
      required this.urls});
}

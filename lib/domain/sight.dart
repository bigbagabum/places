class Sight {
  String name, details, type;
  List<String> img;
  double lat, lng;
  SightStatus status;
  int sightId; // статус :никакой, хочу посетить, посетил

  Sight({
    required this.name,
    required this.details,
    required this.type,
    required this.lat,
    required this.lng,
    required this.img,
    required this.status,
    required this.sightId,
  });

  factory Sight.fromJson(Map<String, dynamic> json) {
    return Sight(
      name: json['name'],
      details: json['description'],
      type: json['placeType'],
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
      img: List<String>.from(json['urls']),
      status: SightStatus.sightNoPlans,
      sightId: json['id'],
    );
  }
}

enum SightStatus {
  sightNoPlans, // статус места на кооторе пока нет планов
  sightToVisit, // статус карточки которую планирую посетить
  sightVisited // статус места которое уже посещено
}

enum SightListIndex {
  mainList, // вид карточки в основном листе
  planList // вид карточки в листе "хочу посетить/посетил"
}

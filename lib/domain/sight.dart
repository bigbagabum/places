class Sight {
  final String name, url, details, type;
  List<String> img;
  final double lat, lng;
  SightStatus status;
  int sightId; // статус :никакой, хочу посетить, посетил

  Sight(this.name, this.url, this.details, this.type, this.lat, this.lng,
      this.img, this.status, this.sightId);
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

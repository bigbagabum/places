import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/sight.dart';

//Map<PlaceDto, SightStatus> tempData = {};
List<Sight> tempData = [];

class PlaceInteractor {
  final PlaceRepository _placeRepository;

  PlaceInteractor(this._placeRepository);

//Получаем список мест отфильтрованных по расстоянию и отсортированных по удаленности
  Future<List<Sight>> getFilteredPlaces(double lat, double lng, double radius,
      List<String> typeFilter, String nameFilter) async {
    try {
      final places = await _placeRepository.filteredPlaces({
        "lat": lat,
        "lng": lng,
        "radius": radius,
        "typeFilter": typeFilter,
        "nameFilter": nameFilter
      });

      places.sort((a, b) => a.distance.compareTo(b.distance));

      final List<Sight> sights = [];
      for (var placeItem in places) {
        Sight newPlace = Sight(
            name: placeItem.name,
            details: placeItem.description,
            type: placeItem.placeType,
            lat: placeItem.lat,
            lng: placeItem.lng,
            img: placeItem.urls,
            status: SightStatus.sightNoPlans,
            sightId: placeItem.id);
        // tempData[placeItem] = SightStatus.sightNoPlans;
        sights.add(newPlace);
      }
      //sights.map((e) => print('${e.name} Место ${e.name}'));

      return sights;
    } catch (error) {
      rethrow;
    }
  }

//Получаем детали места по id
  Future<Sight> getPlaceDetails(String id) async {
    try {
      final places = await _placeRepository.getPlaceById(id);

      return places;
    } catch (error) {
      rethrow; // Передайте ошибку выше,  она произошла
    }
  }

//получаем список со статусами SightStatus.
  List<Sight> getFavoritePlaces() {
    final List<Sight> favoritePlaces = [];

    for (Sight sight in tempData) {
      if (sight.status == SightStatus.sightToVisit) {
        favoritePlaces.add(sight);
      }
    }

    return favoritePlaces;
  }

// добавим существующее место в выборку "избранное"
  void addToFavorites(int sightId) {
    for (int i = 0; tempData[i].sightId != i; i++) {
      if (tempData[i].sightId == i) {
        tempData[i].status = SightStatus.sightToVisit;
      }
    }
    //tempData[sightId] = SightStatus.sightToVisit;
  }

// удалим место из избранного
  void removeFromFavorites(int sightId) {
    // tempData[placeDto] = SightStatus.sightNoPlans;
    for (int i = 0; tempData[i].sightId != i; i++) {
      if (tempData[i].sightId == i) {
        tempData[i].status = SightStatus.sightNoPlans;
      }
    }
  }

// получаем список мест запланированных к посещению

  List<Sight> getVisitPlaces() {
    final List<Sight> favoritePlaces = [];

    for (Sight sight in tempData) {
      if (sight.status == SightStatus.sightToVisit) {
        favoritePlaces.add(sight);
      }
    }

    return favoritePlaces;
  }

// добавляем место в "посещенные"

  void addToVisitedPlaces(int sightId) {
    //tempData[placeDto] = SightStatus.sightVisited;
    for (int i = 0; tempData[i].sightId != i; i++) {
      if (tempData[i].sightId == i) {
        tempData[i].status = SightStatus.sightVisited;
      }
    }
  }

// добавляем новое место

  Future<void> addNewPlace(Place place) async {
    try {
      await _placeRepository.newPlace(place);
    } catch (error) {
      rethrow;
    }
  }
}

import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/errors/error_handlers.dart';
import 'package:places/ui/screen/sight_search/sight_search.dart';

List<Sight> tempData = [];

void clearSearchHistory() {
  searchHistory = [];
}

class PlaceInteractor {
  final PlaceRepository _placeRepository;

  PlaceInteractor(this._placeRepository);

  Future<List<Sight>> filterPlaces(double lat, double lng, double radius,
      List<String> typeFilter, String name) async {
    try {
      final places = await _placeRepository.filteredPlaces({
        "lat": lat,
        "lng": lng,
        "radius": radius,
        "typeFilter": typeFilter,
        "nameFilter": name
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
        sights.add(newPlace);
      }

      return sights;
    } on NetworkException catch (error) {
      print("wir haben ${error.toString} becommen");
      rethrow;
    }
  }

//итерактор поиска по имени из репозтория filteredPlaces
  Future<List<Sight>> searchPlaces(double lat, double lng, double radius,
      List<String> typeFilter, String name) async {
    try {
      final places = await _placeRepository.filteredPlaces({
        "lat": lat,
        "lng": lng,
        "radius": radius,
        "typeFilter": typeFilter,
        "nameFilter": name
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
        sights.add(newPlace);
      }
      //Если нашли чтото по имени фиксируем в истории поиска
      sights.isNotEmpty ? searchHistory.add(name) : null;

      return sights;
    } catch (error) {
      rethrow;
    }
  }

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
        sights.add(newPlace);
      }

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
    for (Sight item in mocks) {
      if (item.sightId == sightId) {
        item.status = SightStatus.sightToVisit;
      }
    }
  }

// удалим место из избранного
  void removeFromFavorites(int sightId) {
    // tempData[placeDto] = SightStatus.sightNoPlans;
    for (Sight item in mocks) {
      if (item.sightId == sightId) {
        item.status = SightStatus.sightNoPlans;
      }
    }
  }

// получаем список мест запланированных к посещению

  List<Sight> getVisitPlaces() {
    final List<Sight> favoritePlaces = [];

    for (Sight sight in mocks) {
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

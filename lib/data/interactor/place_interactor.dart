import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/sight.dart';

Map<PlaceDto, SightStatus> tempData = {};

class PlaceInteractor {
  final PlaceRepository _placeRepository;

  PlaceInteractor(this._placeRepository);

//Получаем список мест отфильтрованных по расстоянию и отсортированных по удаленности
  Future<List<PlaceDto>> getFilteredPlaces(double lat, double lan,
      double radius, List<String> typeFilter, String nameFilter) async {
    try {
      final places = await _placeRepository.filteredPlaces({
        "lat": lat,
        "lng": lan,
        "radius": radius,
        "typeFilter": typeFilter,
        "nameFilter": nameFilter
      });

      places.sort((a, b) => a.distance.compareTo(b.distance));

      for (var placeItem in places) {
        tempData[placeItem] = SightStatus.sightNoPlans;
      }

      return places;
    } catch (error) {
      rethrow;
    }
  }

//Получаем детали места по id
  Future<Place> getPlaceDetails(String id) async {
    try {
      final places = await _placeRepository.getPlaceById(id);

      return places;
    } catch (error) {
      rethrow; // Передайте ошибку выше,  она произошла
    }
  }

//получаем список со статусами SightStatus.
  List<PlaceDto> getFavoritePlaces() {
    final List<PlaceDto> favoritePlaces = [];

    tempData.forEach((placeDto, status) {
      if (status == SightStatus.sightToVisit) {
        favoritePlaces.add(placeDto);
      }
    });

    return favoritePlaces;
  }

// добавим существующее место в выборку "избранное"
  void addToFavorites(PlaceDto placeDto) {
    tempData[placeDto] = SightStatus.sightToVisit;
  }

// удалим место из избранного
  void removeFromFavorites(PlaceDto placeDto) {
    tempData[placeDto] = SightStatus.sightNoPlans;
  }

// получаем список мест запланированных к посещению

  List<PlaceDto> getVisitPlaces() {
    final List<PlaceDto> favoritePlaces = [];

    tempData.forEach((placeDto, status) {
      if (status == SightStatus.sightVisited) {
        favoritePlaces.add(placeDto);
      }
    });

    return favoritePlaces;
  }

// добавляем место в "посещенные"

  void addToVisitedPlaces(PlaceDto placeDto) {
    tempData[placeDto] = SightStatus.sightVisited;
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

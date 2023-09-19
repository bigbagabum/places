import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/place_repository.dart';

class PlaceInteractor {
  final PlaceRepository _placeRepository;

  PlaceInteractor(this._placeRepository);

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

      return places;
    } catch (error) {
      rethrow; // Передайте ошибку выше,  она произошла
    }
  }
}

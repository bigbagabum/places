import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:relation/relation.dart';

class AppState extends ChangeNotifier {
  StreamedState<bool> isLoading = StreamedState<bool>(false);
  StreamedState<Sight?> favoriteStatus = StreamedState<Sight?>(null);

  void setLoading(bool value) {
    isLoading.accept(value);
    notifyListeners();
  }

  void setFavorite(Sight value) {
    favoriteStatus.accept(value);
    notifyListeners();
  }
}

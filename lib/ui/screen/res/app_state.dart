import 'package:flutter/material.dart';
import 'package:relation/relation.dart';

class AppState extends ChangeNotifier {
  StreamedState<bool> isLoading = StreamedState<bool>(false);

  void setLoading(bool value) {
    isLoading.accept(value);
    notifyListeners();
  }
}

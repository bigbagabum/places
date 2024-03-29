import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/router/route_names.dart';

Future<void> initData() async {
  final PlaceRepository placeRepository = PlaceRepository();
  final PlaceInteractor placeInteractor = PlaceInteractor(placeRepository);

  try {
    mocks = await placeInteractor.getFilteredPlaces(
        55.989198,
        37.601605,
        10000.0,
        ["other", "cafe", "restaurant", "park", "museum", "hotel"],
        "");
  } catch (error) {
    print('Error during download data from server: $error');
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    //инициализация приложения.....

    await initData();

    _navigateToNext();
  }

  void _navigateToNext() {
    Navigator.pushNamed(context, Routes.onBoarding);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Splash Screen')),
    );
  }
}

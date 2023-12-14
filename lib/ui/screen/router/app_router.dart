import 'package:flutter/material.dart';
import 'package:places/ui/screen/add_sight/add_sight_screen.dart';
import 'package:places/ui/screen/categories_screen.dart';
import 'package:places/ui/screen/errors/network_error_screen.dart';
import 'package:places/ui/screen/home_page.dart';
import 'package:places/ui/screen/onboarding_screens/onboarding.dart';
import 'package:places/ui/screen/router/route_names.dart';
import 'package:places/ui/screen/sight_details/sight_details.dart';
import 'package:places/ui/screen/sight_search/filters_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';

class AppRouter {
  static Route router(RouteSettings settings) {
    final dynamic args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.homeTabScreen:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnboaardingScreen());
      case Routes.detailedPlace:
        return MaterialPageRoute(
          builder: (_) => SightDetails(
            detailSight: args['detailSight'],
          ),
        );
      case Routes.addSight:
        return MaterialPageRoute(builder: (_) => const AddSightScreen());

      case Routes.setFilterSights:
        return MaterialPageRoute(
            builder: (_) => FiltersScreen(appState: appState));

      case Routes.setTypeSight:
        return MaterialPageRoute(
          builder: (_) => const ChooseCategories(),
        );

      case Routes.netError:
        return MaterialPageRoute(
          builder: (_) => const NetError(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}

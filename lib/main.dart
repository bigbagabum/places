import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/ui/screen/router/app_router.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:places/ui/screen/res/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    ChangeNotifierProvider<MyTheme>(
        create: (context) => MyTheme(), child: const MyApp()),
  );
}

class MyTheme extends ChangeNotifier {
  ThemeData _data = lightTheme;
  static bool isBlack = false;

  ThemeData get currentTheme => _data;

  void changeTheme(bool newTheme) {
    _data = newTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //static bool isBlack = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: context.watch<MyTheme>().currentTheme,
        onGenerateRoute: AppRouter.router,

        // },

        //    home: VisitingScreen());
        //home: const SightListScreen());
        //home: SightCard(sight: mocks[1], listIndex: 0, status: 1));
        // home: SightDetails(sight: mocks[0]));

        home: const SplashScreen());
    //: const HomePage());
    //home: const OnboaardingScreen());

    //home: const FiltersScreen());
    //home: AddSightScreen());
    //home: ChooseCategories());
  }
}

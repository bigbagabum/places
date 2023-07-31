import 'package:flutter/material.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/screen/map_screen.dart';
import 'package:places/ui/screen/onboarding_screens/onboarding_main.dart';
import 'package:places/ui/screen/sight_search/sight_search.dart';
import 'package:provider/provider.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/settings_screen.dart';
//import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

void main() {
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

        //    home: VisitingScreen());
        //home: const SightListScreen());
        //home: SightCard(sight: mocks[1], listIndex: 0, status: 1));
        // home: SightDetails(sight: mocks[0]));

        //home: const HomePage());
        home: const OnboaardingScreen());

    //home: const FiltersScreen());
    //home: AddSightScreen());
    //home: ChooseCategories());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _screenSelected = <Widget>[
    const MainList(),
    //SightListScreen(),
    const MapScreen(),
    const VisitingScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screenSelected.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          //showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 1.0,
          unselectedItemColor: Theme.of(context).secondaryHeaderColor,
          selectedItemColor: Theme.of(context).primaryColorLight,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(AppAssets.iconList),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppAssets.iconMap)),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(AppAssets.iconHeartFull),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(AppAssets.iconSettings)),
              label: '',
            )
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}

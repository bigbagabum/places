import 'package:flutter/material.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/screen/map_screen.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_search/sight_search.dart';
import 'package:places/ui/screen/visiting_screen.dart';

class HomePage extends StatefulWidget {
  //final Orientation orientationDevice;

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screenSelected = <Widget>[
    const MainList(),
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

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/res/app_theme.dart';
import 'package:places/ui/res/app_strings.dart';
//import 'package:places/ui/screen/categories_screen.dart';

import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/sight_search/sight_search_screen.dart';

// класс AppBar наследник от PrefferedSizeWidget

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: AppSize.toolBarSize,
        //elevation: 0,
        centerTitle: true,
        //backgroundColor: Colors.white,
        title: Text(
          AppStrings.appTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 22.0,
              color: Theme.of(context).primaryColorLight,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              height: 1),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52.0),
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            height: 40,
            width: double.infinity,
            child: TextField(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SightSearchScreen(
                              listOfSights: mocks,
                            )));
              },
              readOnly: true,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                fillColor: Theme.of(context).primaryColorDark,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                hintText: AppStrings.searchBar,
                hintStyle: Theme.of(context).textTheme.displaySmall,
                filled: true,
                prefixIcon: Image(image: AssetImage(AppAssets.iconSearch)),
                suffixIcon: Image(image: AssetImage(AppAssets.iconFilter)),
              ),
            ),
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSize.appBarHeight);
}

class SightListScreen extends StatefulWidget {
  final listKey = ValueKey(mocks);

  SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).selectedRowColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddSightScreen()));
        },
        label: Text(
          AppStrings.addPlace,
          style: TextStyle(fontSize: 18),
        ),
        icon: const Icon(Icons.add),
      ),
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: mocks
              .map((mock) => SightCard(
                    sight: mock,
                    listIndex: SightListIndex.mainList,
                    status: mock.status,
                    listKey: ValueKey(mock.sightId),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

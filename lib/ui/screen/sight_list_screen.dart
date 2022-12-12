// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/res/app_theme.dart';
import 'package:places/ui/res/app_strings.dart';

// класс AppBar наследник от PrefferedSizeWidget

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: AppSize.toolBarSize,
        elevation: 0,
        //backgroundColor: Colors.white,
        title: Text(
          AppStrings.appTitle,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 32.0,
              color: Theme.of(context).primaryColorLight,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              height: 1),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSize.appBarHeight);
}

class SightListScreen extends StatefulWidget {
  //final listIndex = SightListIndex.mainList;

  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () {},
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
                  status: mock.status))
              .toList(),
        ),
      ),
    );
  }
}

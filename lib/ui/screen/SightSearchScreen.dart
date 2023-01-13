import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/FiltersScreen.dart';

import '../../domain/sight.dart';
import '../res/app_assets.dart';
import '../res/app_strings.dart';
import '../res/app_theme.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  // TODO: implement preferredSize

  @override
  Size get preferredSize => Size.fromHeight(AppSize.appBarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  List<Sight> nameIsSame =
      []; //этот список будет формироваться от текстового поля

  var TextSearchFieldController = TextEditingController();

//получаем отфильттрованный по вхождению строки в название список мест
  List<Sight> filteredListOfItems(String inputMask, List<Sight> listData) {
    List<Sight> nameIsSame = [];

    for (Sight checkSight in listData) {
      if (checkSight.name.contains(inputMask)) {
        {
          nameIsSame.add(checkSight);
          print(checkSight.name);
        }
      }
    }
    return nameIsSame;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: AppSize.toolBarSize,
        elevation: 0,
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
              //onTap: () {},
              controller: TextEditingController(),
              textAlignVertical: TextAlignVertical.center,
              onChanged: (_) => {
                for (var i in (filteredListOfItems(
                    TextEditingController().text, mocks)))
                  {}
              }, //обрабатываем ввод в сттроке поиска
              decoration: InputDecoration(
                fillColor: Theme.of(context).primaryColorDark,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                hintText: AppStrings.searchBar,
                hintStyle: Theme.of(context).textTheme.headline3,
                filled: true,
                prefixIcon: Image(image: AssetImage(AppAssets.iconSearch)),
                suffixIcon: IconButton(
                    onPressed: () {
                      //клик на иконку фильтра
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FiltersScreen()));
                    },
                    icon: Image(image: AssetImage(AppAssets.iconFilter))),
              ),
            ),
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSize.appBarHeight);
}

class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({Key? key}) : super(key: key);

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  // List<Sight> nameIsSame =
  //     []; //этот список будет формироваться от текстового поля

//   var TextSearchFieldController = TextEditingController();
// //получаем отфильттрованный по вхождению строки в название список мест
//   List<Sight> filteredListOfItems(String inputMask, List<Sight> listData) {
//     for (Sight checkSight in listData) {
//       if (checkSight.name.contains(inputMask)) {
//         {
//           nameIsSame.add(checkSight);
//         }

//       }
//     }
//     return nameIsSame;
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: MyAppBar(), body: Column(children: []));
  }
}

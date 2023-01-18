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

class SightSearchScreen extends StatefulWidget {
  SightSearchScreen({Key? key}) : super(key: key);

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  List<Sight> sightF = [];

  //получаем отфильттрованный по вхождению строки в название список мест
  List<Sight> filteredListOfItems(String inputMask, List<Sight> listData) {
    List<Sight> nameIsSame = [];

    for (Sight checkSight in listData) {
      if (checkSight.name.contains(inputMask)) {
        nameIsSame.add(checkSight);
        print(checkSight.name);
        // print(inputMask);
      }
    }
    return nameIsSame;
    //sightF = nameIsSame;
  }

  var TextSearchFieldController = TextEditingController();

  Widget SeightLine(Sight inputSight) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              height: 56,
              width: 56,
              child: Image(
                image: AssetImage(inputSight.img),
              ),
            )
          ],
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Color.fromARGB(56, 124, 126, 146),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                  controller: TextSearchFieldController,
                  textAlignVertical: TextAlignVertical.center,
                  onSubmitted: (_) {
                    //обрабатываем ввод в строке поиска
                    //filteredListOfItems(TextSearchFieldController.text, mocks);

                    setState(() {
                      sightF = filteredListOfItems(
                          TextSearchFieldController.text, mocks);
                    });
                  },
                  onChanged: (_) {
                    //обрабатываем ввод в строке поиска
                    setState(() {
                      if (TextSearchFieldController.text.endsWith(' ')) {
                        sightF = filteredListOfItems(
                            TextSearchFieldController.text.substring(
                                1, TextSearchFieldController.text.length - 1),
                            mocks);
                      }
                    });
                  },

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
            )),
        body: Column(
            children: (sightF.map((item) => SeightLine(item))).toList()));
  }
}

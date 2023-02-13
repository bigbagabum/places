import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/sight_details.dart';

import '../../domain/sight.dart';
import '../res/app_assets.dart';
import '../res/app_strings.dart';
import '../res/app_theme.dart';

class SightSearchScreen extends StatefulWidget {
  SightSearchScreen({Key? key, required List<Sight> inputSightList})
      : super(key: key) {
    this.sightList = inputSightList;
  }

  late List<Sight> sightList;

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
//get listSelected => null;

  IconButton _suffixIcon(bool searchIsEmpty) {
    if (searchIsEmpty) {
      return IconButton(
          onPressed: () async {
            //клик на иконку фильтра
            List<Sight> customList = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => FiltersScreen()));

            widget.sightList = customList;
          },
          // ignore: prefer_const_constructors
          icon: Image(
            image: AssetImage(AppAssets.iconFilter),
          ));
    }
    {
      return IconButton(
        icon: SvgPicture.asset(AppAssets.iconCancel),
        onPressed: () {
          TextSearchFieldController.clear();
          setState(() {
            filteredSightsList = [];
          });
        },
      );
    }
    ;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.

    TextSearchFieldController.dispose();

    super.dispose();
  }

  String Mask() {
    return TextSearchFieldController.text.endsWith(' ')
        ? TextSearchFieldController.text
            .substring(0, TextSearchFieldController.text.length - 1)
        : TextSearchFieldController.text;
  }

  // ignore: non_constant_identifier_names
  List<TextSpan> NameOfSight(String inputMask, String originalName) {
    List<String> nameWithMask;
    List<TextSpan> stringWithStyle = [];

    if (originalName.indexOf(Mask()) >= 0) {
      stringWithStyle.add(TextSpan(
          text: originalName.substring(0, originalName.indexOf(Mask())),
          style: Theme.of(context).textTheme.headline5));

      stringWithStyle.add(
        TextSpan(text: Mask(), style: Theme.of(context).textTheme.headline6),
      );

      stringWithStyle.add(TextSpan(
          text: originalName.substring(
              originalName.indexOf(Mask()) + Mask().length,
              originalName.length),
          style: Theme.of(context).textTheme.headline5));
    }

    return stringWithStyle;
  }

  late List<Sight> filteredSightsList = [];
  List<String> searchHistory = []; //Список итемов истории поиска

  Widget SearchHistoryItem(String itemName, int itemIndex) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            itemName,
            style: Theme.of(context).textTheme.headline3,
          ),
          Spacer(),
          GestureDetector(
              onTap: () {
                searchHistory.removeAt(itemIndex);
                setState(() {});
              },
              child: SvgPicture.asset(AppAssets.iconCancel))
        ]),
        Container(
          height: 1,
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          color: Theme.of(context).secondaryHeaderColor,
        ),
      ]),
    );
  }

  //получаем отфильттрованный по вхождению строки в название список мест
  List<Sight> FilteredListOfItems(String inputMask, List<Sight> listData) {
    List<Sight> nameIsSame = [];

    for (Sight checkSight in listData) {
      if (checkSight.name.contains(inputMask)) {
        nameIsSame.add(checkSight);
      }
    }
    nameIsSame.isEmpty ? null : searchHistory.add(inputMask);
    return nameIsSame;
  }

  var TextSearchFieldController = TextEditingController();

  Widget SeightLine(Sight inputSight) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: InkWell(
        //клики на строчку поисковой выдаси
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SightDetails(detailSight: inputSight),
            ),
          );
        },
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 56,
                    width: 56,
                    child: SizedBox(
                      child: Image(
                        image: AssetImage(inputSight.img),
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),

                            //child
                          );
                        },
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            //text: inputSight.name,
                            children: NameOfSight(
                                TextSearchFieldController.text,
                                inputSight.name)),

                        //  style: Theme.of(context).textTheme.headline5
                      ),
                      SizedBox(height: 8),
                      Text(inputSight.type,
                          style: Theme.of(context).textTheme.headline4)
                    ],
                  )
                ],
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                color: Theme.of(context).secondaryHeaderColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget BodyContent() {
    if (filteredSightsList.isEmpty) {
      if (searchHistory.isEmpty == false) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 38,
            ),
            child: Text(AppStrings.searchHistory,
                style: Theme.of(context).textTheme.headline4),
          ),
          Column(
              children: (searchHistory
                      .asMap()
                      .entries
                      .map((item) => SearchHistoryItem(item.value, item.key)))
                  .toList()),
          GestureDetector(
              onTap: () {
                setState(() {
                  searchHistory = [];
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 28),
                child: Text(AppStrings.clearHistory,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Colors.green)),
              ))
        ]);
      }
      return Text('');
    }
    return Column(
      children: (filteredSightsList.map((item) => SeightLine(item))).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              //onTap: () {},
              controller: TextSearchFieldController,
              textAlignVertical: TextAlignVertical.center,
              onSubmitted: (_) {
                //обрабатываем ввод в строке поиска

                if (TextSearchFieldController.text.isNotEmpty) {
                  setState(() {
                    filteredSightsList = FilteredListOfItems(
                        TextSearchFieldController.text, widget.sightList);
                  });
                } else {
                  filteredSightsList = [];
                }
              },
              onChanged: (_) {
                //обрабатываем ввод в строке поиска
                if (TextSearchFieldController.text.endsWith(' ')) {
                  setState(
                    () {
                      if (TextSearchFieldController.text.endsWith(' ') &&
                          !TextSearchFieldController.text.startsWith(' ')) {
                        filteredSightsList = FilteredListOfItems(
                            TextSearchFieldController.text.substring(
                                0, TextSearchFieldController.text.length - 1),
                            widget.sightList);

                        // print('new search ');
                        // print(widget.sightList.map((e) => e.name));

                      }
                    },
                  );
                } else if (TextSearchFieldController.text.isEmpty) {
                  setState(() {
                    filteredSightsList = [];
                  });
                } else
                  setState(() {});
              },

              decoration: InputDecoration(
                  fillColor: Theme.of(context).primaryColorDark,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: AppStrings.searchBar,
                  hintStyle: Theme.of(context).textTheme.headline3,
                  filled: true,
                  prefixIcon: Image(
                    image: const AssetImage(AppAssets.iconSearch),
                  ),
                  suffixIcon: _suffixIcon(Mask().isEmpty)),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(child: BodyContent()),

      // Column(
      //   children: (filteredSightsList.map((item) => SeightLine(item))).toList(),
      // ),
    );
  }
}

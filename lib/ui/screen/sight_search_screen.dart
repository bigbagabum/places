import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/sight_details.dart';

import '../../domain/sight.dart';
import '../res/app_assets.dart';
import '../res/app_strings.dart';
import '../res/app_theme.dart';

class SightSearchScreen extends StatefulWidget {
  SightSearchScreen({Key? key, required this.sightList}) : super(key: key);

  List<Sight> sightList;

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
                MaterialPageRoute(builder: (context) => const FiltersScreen()));

            widget.sightList = customList;
          },
          icon: const Image(
            image: AssetImage(AppAssets.iconFilter),
          ));
    }
    {
      return IconButton(
        icon: const Image(image: AssetImage(AppAssets.iconCancel)),
        onPressed: () {
          textSearchFieldController.clear();
          setState(() {
            filteredSightsList = [];
          });
        },
      );
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.

    textSearchFieldController.dispose();

    super.dispose();
  }

  String mask() {
    return textSearchFieldController.text.toLowerCase().endsWith(' ')
        ? textSearchFieldController.text
            .substring(0, textSearchFieldController.text.length - 1)
        : textSearchFieldController.text;
  }

  List<TextSpan> nameOfSight(String inputMask, String originalName) {
    List<TextSpan> stringWithStyle = [];

    int index = originalName.toLowerCase().indexOf(inputMask.toLowerCase());
    if (index >= 0) {
      String beforeMask = originalName.substring(0, index);
      String mask = originalName.substring(index, index + inputMask.length);
      String afterMask = originalName.substring(index + inputMask.length);

      stringWithStyle.add(TextSpan(
        text: beforeMask,
        style: Theme.of(context).textTheme.headlineSmall,
      ));

      stringWithStyle.add(TextSpan(
        text: mask,
        style: Theme.of(context).textTheme.titleLarge,
      ));

      stringWithStyle.add(TextSpan(
        text: afterMask,
        style: Theme.of(context).textTheme.headlineSmall,
      ));
    } else {
      stringWithStyle.add(TextSpan(
        text: originalName,
        style: Theme.of(context).textTheme.headlineSmall,
      ));
    }

    return stringWithStyle;
  }

  late List<Sight> filteredSightsList = [];
  List<String> searchHistory = []; //Список итемов истории поиска

  Widget searchHistoryItem(String itemName, int itemIndex) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            itemName,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const Spacer(),
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

//экран пустого результата поиска
  Widget emptySearchResult() {
    return Column(children: [
      Image(
        image: AssetImage(AppAssets.iconEmptySearch),
      )
    ]);
  }

  //получаем отфильттрованный по вхождению строки в название список мест
  List<Sight> filteredListOfItems(String inputMask, List<Sight> listData) {
    List<Sight> nameIsSame = [];

    for (Sight checkSight in listData) {
      if (checkSight.name.toLowerCase().contains(inputMask)) {
        nameIsSame.add(checkSight);
      }
    }
    nameIsSame.isEmpty ? {} : searchHistory.add(inputMask);
    return nameIsSame;
  }

  var textSearchFieldController = TextEditingController();

  Widget seightLine(Sight inputSight) {
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
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
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
                          children: nameOfSight(
                              textSearchFieldController.text, inputSight.name)),
                    ),
                    const SizedBox(height: 8),
                    Text(inputSight.type,
                        style: Theme.of(context).textTheme.headlineMedium)
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
    );
  }

  Widget searchHistoryScreen() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 38,
        ),
        child: Text(AppStrings.searchHistory,
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      Column(
          children: (searchHistory
                  .asMap()
                  .entries
                  .map((item) => searchHistoryItem(item.value, item.key)))
              .toList()),
      GestureDetector(
          onTap: () {
            setState(() {
              searchHistory = [];
            });
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 16, top: 28),
            child: Text(AppStrings.clearHistory,
                style: TextStyle(
                    fontFamily: 'Roboto', fontSize: 16, color: Colors.green)),
          ))
    ]);
  }

  Widget bodyContent() {
    if (filteredSightsList.isEmpty) {
      if (textSearchFieldController.text.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage(AppAssets.iconEmptySearch),
              ),
              const SizedBox(height: 16.0),
              Text(
                AppStrings.emptySearchResult,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8.0),
              Text(
                AppStrings.tryToChangeParametersForSearch,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    } else {
      return Column(
        children: (filteredSightsList.map((item) => seightLine(item))).toList(),
      );
    }
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
            margin: const EdgeInsets.only(left: 16, right: 16),
            height: 40,
            width: double.infinity,
            child: TextField(
              //onTap: () {},
              controller: textSearchFieldController,
              textAlignVertical: TextAlignVertical.center,
              onSubmitted: (_) {
                //обрабатываем ввод в строке поиска

                if (textSearchFieldController.text.isNotEmpty) {
                  setState(() {
                    filteredSightsList = filteredListOfItems(
                        textSearchFieldController.text, widget.sightList);
                  });
                } else {
                  filteredSightsList = [];
                }
              },
              onChanged: (_) {
                //обрабатываем ввод в строке поиска
                if (textSearchFieldController.text
                    .toLowerCase()
                    .endsWith(' ')) {
                  setState(
                    () {
                      if (textSearchFieldController.text
                              .toLowerCase()
                              .endsWith(' ') &&
                          !textSearchFieldController.text
                              .toLowerCase()
                              .startsWith(' ')) {
                        filteredSightsList = filteredListOfItems(
                            textSearchFieldController.text
                                .toLowerCase()
                                .substring(0,
                                    textSearchFieldController.text.length - 1),
                            widget.sightList);

                        // print('new search ');
                        // print(widget.sightList.map((e) => e.name));
                      }
                    },
                  );
                } else if (textSearchFieldController.text.isEmpty) {
                  setState(() {
                    filteredSightsList = [];
                  });
                } else {
                  setState(() {});
                }
              },

              decoration: InputDecoration(
                  fillColor: Theme.of(context).primaryColorDark,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: AppStrings.searchBar,
                  hintStyle: Theme.of(context).textTheme.displaySmall,
                  filled: true,
                  prefixIcon: const Image(
                    image: AssetImage(AppAssets.iconSearch),
                  ),
                  suffixIcon: _suffixIcon(mask().isEmpty)),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(child: bodyContent()),
    );
  }
}

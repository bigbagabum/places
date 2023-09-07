import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_theme.dart';
import 'package:places/ui/screen/router/route_names.dart';
import 'package:places/ui/screen/sight_search/sight_search_model.dart';
import 'package:places/ui/screen/sight_card.dart';

List<Sight> sightList = mocks; //входной поток данных
List<Sight> filteredSightsList =
    []; // поток данных после примененных фильтров и ввода строки поиска
List<String> searchHistory = []; //Список итемов истории поиска

class MainList extends StatefulWidget {
  const MainList({Key? key}) : super(key: key);

  @override
  State<MainList> createState() => _MainList();
}

class _MainList extends State<MainList> {
  @override
  void dispose() {
    textSearchFieldController.dispose();

    super.dispose();
  }

  String mask() {
    return textSearchFieldController.text.toLowerCase().endsWith(' ')
        ? textSearchFieldController.text
            .substring(0, textSearchFieldController.text.length - 1)
        : textSearchFieldController.text;
  }

  var textSearchFieldController = TextEditingController();

  // Widget searchHistoryScreen() {
  //   return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //     Padding(
  //       padding: const EdgeInsets.only(
  //         left: 16,
  //         top: 38,
  //       ),
  //       child: Text(AppStrings.searchHistory,
  //           style: Theme.of(context).textTheme.headlineMedium),
  //     ),
  //     Column(
  //         children: (searchHistory.asMap().entries.map((item) =>
  //                 HistorySearchItem(itemName: item.value, itemIndex: item.key)))
  //             .toList()),
  //     GestureDetector(
  //         onTap: () {
  //           setState(() {
  //             searchHistory = [];
  //           });
  //         },
  //         child: const Padding(
  //           padding: EdgeInsets.only(left: 16, top: 28),
  //           child: Text(AppStrings.clearHistory,
  //               style: TextStyle(
  //                   fontFamily: 'Roboto', fontSize: 16, color: Colors.green)),
  //         ))
  //   ]);
  // }

  Widget bodyContentPortrait() {
    if (filteredSightsList.isEmpty) {
      if (textSearchFieldController.text.isNotEmpty) {
        // вывод пустого результата поиска
        return SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
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
          ),
        );
      } else {
        // вывод без фильтра все подряд
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return SightCard(
                sight: mocks[index],
                listIndex: SightListIndex.mainList,
              );
            },
            childCount: mocks.length,
          ),
        );
      }
    } else {
      // отфильтрованный список
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return SeightLine(
                inputSight: filteredSightsList[index],
                maskOfSearch: textSearchFieldController.text);
          },
          childCount: filteredSightsList.length,
        ),
      );
    }
  }

  Widget bodyContentLandscape() {
    if (filteredSightsList.isEmpty) {
      if (textSearchFieldController.text.isNotEmpty) {
        // вывод пустого результата поиска
        return SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
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
          ),
        );
      } else {
        // вывод без фильтра все подряд
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return SightCard(
                sight: mocks[index],
                listIndex: SightListIndex.mainList,
              );
            },
            childCount: mocks.length,
          ),
        );
      }
    } else {
      // отфильтрованный список
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return SeightLine(
                inputSight: filteredSightsList[index],
                maskOfSearch: textSearchFieldController.text);
          },
          childCount: filteredSightsList.length,
        ),
      );
    }
  }

  Widget bodyContent() {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return bodyContentPortrait();
        } else {
          return bodyContentLandscape();
        }
      },
    );
  }

  void clearSearch() {
    textSearchFieldController.clear();
    setState(() {
      filteredSightsList = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: AppSize.toolBarSize + 52,
              centerTitle: true,
              title: const AppBarTextTitle(),
              flexibleSpace: FlexibleSpaceBar(
                background: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    height: 40,
                    width: double.infinity,
                    child: TextField(
                      controller: textSearchFieldController,
                      textAlignVertical: TextAlignVertical.center,
                      onSubmitted: (_) {
                        //обрабатываем ввод в строке поиска

                        if (textSearchFieldController.text.isNotEmpty) {
                          setState(() {
                            filteredSightsList = filteredListOfItems(
                                textSearchFieldController.text, sightList);
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
                                        .substring(
                                            0,
                                            textSearchFieldController
                                                    .text.length -
                                                1),
                                    sightList);
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
                          suffixIcon: SuffixIcon(
                            searchIsEmpty: mask().isEmpty,
                            clearTextController: clearSearch,
                          )),
                    ),
                  ),
                ),
              ),
            ),
            bodyContent(),
          ],
        ),
        Positioned(
          right: MediaQuery.of(context).size.width / 2 - 70,
          bottom: 16.0,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).selectedRowColor),
            ),
            onPressed: () => {Navigator.pushNamed(context, Routes.addSight)},
            child: Row(
              children: [
                const Icon(Icons.add),
                Text(
                  AppStrings.addPlace,
                  style: Theme.of(context).textTheme.button,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

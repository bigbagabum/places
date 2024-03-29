import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_theme.dart';
import 'package:places/ui/screen/res/app_state.dart';
import 'package:places/ui/screen/router/route_names.dart';
import 'package:places/ui/screen/sight_search/filters_screen.dart';
import 'package:places/ui/screen/sight_search/sight_search_model.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

List<Sight> sightList = mocks; //входной поток данных
List<Sight> filteredSightsList =
    []; // поток данных после примененных фильтров и ввода строки поиска
List<String> searchHistory = []; //Список итемов истории поиска

class MainList extends StatefulWidget {
  final Orientation orientation;
  final AppState appState;
  const MainList({
    Key? key,
    required this.orientation,
    required this.appState,
  }) : super(key: key);

  @override
  State<MainList> createState() => _MainList();
}

class _MainList extends State<MainList> {
  @override
  void dispose() {
    textSearchFieldController.dispose();
    super.dispose();
  }

  void updateFilteredListOfItems() {
    //setState(() {});
  }

  String mask() {
    return textSearchFieldController.text.toLowerCase().endsWith(' ')
        ? textSearchFieldController.text
            .substring(0, textSearchFieldController.text.length - 1)
        : textSearchFieldController.text;
  }

  var textSearchFieldController = TextEditingController();

  Widget bodyContent() {
    if (filteredSightsList.isEmpty) {
      //Если список отфильтрованных мест пуст
      if (textSearchFieldController.text.isNotEmpty) {
        // при этом если текстовое поле ввода НЕ ПУСТОЕ
        if (searchHistory.isEmpty) //При этом в истории поиска ничего нет

        {
          //показываем заглушку про пустой поиск
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
          //если при этом есть история поиска, тогда отображаем историю поиска
          return SliverToBoxAdapter(
              key: UniqueKey(),
              child: SearchHistory(updateScreen: () => setState(() {})));
        }
      } else {
        // а если отфильтрованный список filteredSightsList пуст но при этом тестовое поле не пустое отображаем все подряд
        // вывод без фильтра все подряд из mocks[]
        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                (widget.orientation == Orientation.portrait) ? 1 : 2,
            childAspectRatio: 3 / 2,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return SightCard(
                sight: sightList[index],
                listIndex: SightListIndex.mainList,
              );
            },
            childCount: sightList.length,
          ),
        );
      }
    } else {
      // но всетаки если filteredSightsList не пуст и есть совпадения тогда отображаем список из совпалений
      // отфильтрованный список
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (widget.orientation == Orientation.portrait) ? 1 : 2,
          childAspectRatio: 3 / 2,
        ),
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
        body: StreamedStateBuilder<bool>(
            streamedState: Provider.of<AppState>(context).isLoading,
            builder: (context, isLoading) {
              return Stack(children: [
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
                            margin: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8),
                            height: 40,
                            width: double.infinity,
                            child: TextField(
                              controller: textSearchFieldController,
                              textAlignVertical: TextAlignVertical.center,
                              onSubmitted: (_) async {
                                //обрабатываем ввод в строке поиска

                                if (textSearchFieldController.text.isNotEmpty) {
                                  await searchPlace(
                                      55.989198,
                                      37.601605,
                                      maxDistance,
                                      choosedTypes,
                                      textSearchFieldController.text,
                                      widget.appState);

                                  setState(() {
                                    // filteredSightsList = filteredListOfItems(
                                    //     textSearchFieldController.text, sightList);
                                  });
                                } else {
                                  filteredSightsList = [];
                                }
                              },
                              onChanged: (_) async {
                                //обрабатываем ввод в строке поиска
                                if (textSearchFieldController.text
                                    .toLowerCase()
                                    .endsWith(' ')) {
                                  if (textSearchFieldController.text
                                          .toLowerCase()
                                          .endsWith(' ') &&
                                      !textSearchFieldController.text
                                          .toLowerCase()
                                          .startsWith(' ')) {
                                    await searchPlace(
                                        redSquare.latitude,
                                        redSquare.longitude,
                                        maxDistance,
                                        choosedTypes,
                                        textSearchFieldController.text
                                            .toLowerCase()
                                            .substring(
                                                0,
                                                textSearchFieldController
                                                        .text.length -
                                                    1),
                                        widget.appState);
                                    setState(() {});
                                  }
                                } else if (textSearchFieldController
                                    .text.isEmpty) {
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
                                  hintStyle:
                                      Theme.of(context).textTheme.displaySmall,
                                  filled: true,
                                  prefixIcon: const Image(
                                    image: AssetImage(AppAssets.iconSearch),
                                  ),
                                  suffixIcon: SuffixIcon(
                                      searchIsEmpty: mask().isEmpty,
                                      clearTextController: clearSearch,
                                      callBack: updateFilteredListOfItems)),
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
                    onPressed: () =>
                        {Navigator.pushNamed(context, Routes.addSight)},
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
              ]);
            }));
  }
}

import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'dart:io';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_theme.dart';
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

  var textSearchFieldController = TextEditingController();

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
          children: (searchHistory.asMap().entries.map((item) =>
                  HistorySearchItem(itemName: item.value, itemIndex: item.key)))
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
        return
            //вывод пустого результата поиска
            Center(
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
        );
      } else {
        return Padding(
          //вывод без фильтра все подряд

          padding: const EdgeInsets.only(top: 15),
          child: ListView.builder(
              cacheExtent: 10,
              physics: Platform.isAndroid
                  ? const ClampingScrollPhysics()
                  : const BouncingScrollPhysics(),
              itemCount: mocks.length,
              itemBuilder: (context, index) {
                return SightCard(
                    sight: mocks[index],
                    listIndex: SightListIndex.mainList,
                    status: mocks[index].status,
                    listKey: ValueKey(mocks[index].sightId));
              }),
        );
      }
    } else {
      //отфильтрованый список
      return ListView.builder(
          //physics:  isAndroid? => const ClampingScrollPhysics():BouncingScrollPhysics(),
          cacheExtent: 20,
          physics: Platform.isAndroid
              ? const ClampingScrollPhysics()
              : const BouncingScrollPhysics(),
          itemCount: filteredSightsList.length,
          itemBuilder: (context, index) {
            return SeightLine(
                inputSight: filteredSightsList[index],
                maskOfSearch: textSearchFieldController.text);
          });
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
      appBar: AppBar(
        toolbarHeight: AppSize.toolBarSize,
        centerTitle: true,
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
                                .substring(0,
                                    textSearchFieldController.text.length - 1),
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
      resizeToAvoidBottomInset: false,
      body: bodyContent(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).selectedRowColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddSightScreen()));
        },
        label: const Text(
          AppStrings.addPlace,
          style: TextStyle(fontSize: 18),
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

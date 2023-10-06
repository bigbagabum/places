import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/screen/router/route_names.dart';

import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/sight_search/sight_search.dart';

List<String> choosedTypes = [
  "other",
  "cafe",
  "restaurant",
  "park",
  "museum",
  "hotel"
];
double maxDistance = 10000;

var textSearchFieldController =
    TextEditingController(); // контроллер строки ввода

Future<void> searchPlace(double lat, double lng, double radius,
    List<String> typePlaces, String name) async {
  final PlaceRepository placeRepository = PlaceRepository();
  final PlaceInteractor placeInteractor = PlaceInteractor(placeRepository);

  try {
    filteredSightsList =
        await placeInteractor.searchPlaces(lat, lng, radius, typePlaces, name);
  } catch (error) {
    print('Error during download data from server: $error');
  }
}

class NameSightInSearch extends StatefulWidget {
  final String inputMask;
  final String originalName;
  const NameSightInSearch(
      {super.key, required this.inputMask, required this.originalName});

  @override
  State<NameSightInSearch> createState() => _NameSightInSearch();
}

class _NameSightInSearch extends State<NameSightInSearch> {
  @override
  Widget build(BuildContext context) {
    List<TextSpan> stringWithStyle = [];

    int index = widget.originalName
        .toLowerCase()
        .indexOf(widget.inputMask.toLowerCase());

    if (index >= 0) {
      String beforeMask = widget.originalName.substring(0, index);
      String mask =
          widget.originalName.substring(index, index + widget.inputMask.length);
      String afterMask =
          widget.originalName.substring(index + widget.inputMask.length);

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
        text: widget.originalName,
        style: Theme.of(context).textTheme.headlineSmall,
      ));
    }

    return RichText(
      text: TextSpan(children: stringWithStyle),
      //softWrap: true,
      //overflow: TextOverflow.clip,
    );
  }
}

class SearchHistory extends StatefulWidget {
  final VoidCallback updateScreen;
  const SearchHistory({super.key, required this.updateScreen});

  @override
  State<SearchHistory> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  @override
  Widget build(BuildContext context) {
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
              HistorySearchItem(
                  itemName: item.value,
                  itemIndex: item.key,
                  updateScreen: () => setState(() {})))).toList()),
      GestureDetector(
          onTap: () {
            searchHistory = [];
            print('История поиска очищена');
            widget.updateScreen.call();
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 16, top: 28),
            child: Text(AppStrings.clearHistory,
                style: TextStyle(
                    fontFamily: 'Roboto', fontSize: 16, color: Colors.green)),
          ))
    ]);
  }
}

//возвращаем в SearchHistory историю запросов поиска
class HistorySearchItem extends StatefulWidget {
  final String itemName;
  final int itemIndex;
  final VoidCallback updateScreen;

  const HistorySearchItem(
      {super.key,
      required this.itemIndex,
      required this.itemName,
      required this.updateScreen});

  @override
  State<HistorySearchItem> createState() => _HistorySearchItem();
}

class _HistorySearchItem extends State<HistorySearchItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            widget.itemName,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const Spacer(),
          GestureDetector(
              onTap: () {
                searchHistory.removeAt(widget.itemIndex);
                widget.updateScreen();
              },
              child: const Image(image: AssetImage(AppAssets.iconCancel)))
        ]),
        const Divider()
      ]),
    );
  }
}

//строчка поисковой выдачи
class SeightLine extends StatefulWidget {
  final String maskOfSearch;
  final Sight inputSight;
  const SeightLine(
      {super.key, required this.maskOfSearch, required this.inputSight});

  @override
  State<SeightLine> createState() => _SeightLineState();
}

class _SeightLineState extends State<SeightLine> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: InkWell(
        //клики на строчку поисковой выдачи
        onTap: () {
          Navigator.pushNamed(context, Routes.detailedPlace,
              arguments: {"detailSight": widget.inputSight});
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
                    child: Image.network(
                      widget.inputSight.img[0],
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
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NameSightInSearch(
                          inputMask: widget.maskOfSearch,
                          originalName: widget.inputSight.name),
                      const SizedBox(height: 8),
                      Text(widget.inputSight.type,
                          style: Theme.of(context).textTheme.headlineMedium)
                    ],
                  ),
                )
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

// //метод возвращает список мест отфильтрованных по маске ввода и дополняет историю поиска
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

//иконка в конце строки ввода
class SuffixIcon extends StatefulWidget {
  final VoidCallback callBack;
  final bool searchIsEmpty;
  final Function clearTextController;

  const SuffixIcon(
      {super.key,
      required this.searchIsEmpty,
      required this.clearTextController,
      required this.callBack()});

  @override
  State<SuffixIcon> createState() => _SuffixIconState();
}

class _SuffixIconState extends State<SuffixIcon> {
  @override
  Widget build(BuildContext context) {
    if (widget.searchIsEmpty) {
      return IconButton(
          onPressed: () async {
            //клик на иконку фильтра

            var customList;
            try {
              customList =
                  await Navigator.pushNamed(context, Routes.setFilterSights);

              if (customList != null) {
                sightList = customList;
                widget.callBack();
                final List<dynamic> parameters = customList;
                choosedTypes = parameters[0];
                maxDistance = parameters[1];
              }
            } catch (error) {
              print('Then filter clicked we get NULL from customList $error');
            }
          },
          icon: const Image(
            image: AssetImage(AppAssets.iconFilter),
          ));
    }
    {
      //клик на иконку отчистки строки поиска
      return IconButton(
        icon: const Image(image: AssetImage(AppAssets.iconCancel)),
        onPressed: () {
          widget.clearTextController();
        },
      );
    }
  }
}

class AppBarTextTitle extends StatefulWidget {
  const AppBarTextTitle({super.key});

  @override
  State<AppBarTextTitle> createState() => _AppBarTextTitleState();
}

class _AppBarTextTitleState extends State<AppBarTextTitle> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //height: 60,
      child: Text(
        AppStrings.appTitle,
        textAlign: TextAlign.center,
        softWrap: true,
        overflow: TextOverflow.visible,
        style: TextStyle(
            fontSize: 22.0,
            color: Theme.of(context).primaryColorLight,
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold,
            height: 1),
      ),
    );
  }
}

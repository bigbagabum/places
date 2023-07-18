import 'package:flutter/material.dart';
import 'package:places/ui/screen/sight_details.dart';

import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';

List<Sight> filteredSightsList = [];
List<String> searchHistory = []; //Список итемов истории поиска
var textSearchFieldController = TextEditingController();

class BodyMainList extends StatefulWidget {
  const BodyMainList({super.key});

  @override
  State<BodyMainList> createState() => _BodyMainListState();
}

class _BodyMainListState extends State<BodyMainList> {
  @override
  Widget build(BuildContext context) {
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
        children: (filteredSightsList
            .map((item) => SightLine(inputSight: item))).toList(),
      );
    }
  }
}

class SightLine extends StatefulWidget {
  final Sight inputSight;
  const SightLine({super.key, required this.inputSight});

  @override
  State<SightLine> createState() => _SightLineState();
}

class _SightLineState extends State<SightLine> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: InkWell(
        //клики на строчку поисковой выдаси
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SightDetails(detailSight: widget.inputSight),
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
                      image: AssetImage(widget.inputSight.img),
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
                    NameSightInSearch(
                        inputMask: textSearchFieldController.text,
                        originalName: widget.inputSight.name),
                    // RichText(
                    //   text: TextSpan(
                    //     children:

                    //         NameSightInSearch(
                    //         inputMask: textSearchFieldController.text,
                    //         originalName: widget.inputSight.name),
                    //   ),
                    // ),
                    const SizedBox(height: 8),
                    Text(widget.inputSight.type,
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

    return RichText(text: TextSpan(children: stringWithStyle));
  }
}

//возвращаем в body историю запросов поиска
class HistoryOfSearch extends StatefulWidget {
  final String itemName;
  final int itemIndex;
  const HistoryOfSearch(
      {super.key, required this.itemIndex, required this.itemName});

  @override
  State<HistoryOfSearch> createState() => _HistoryOfSearchState();
}

class _HistoryOfSearchState extends State<HistoryOfSearch> {
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
                setState(() {});
              },
              child: const Image(image: AssetImage(AppAssets.iconCancel)))
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
}

//экран пустого результата поиска
class EmptySearch extends StatefulWidget {
  const EmptySearch({super.key});

  @override
  State<EmptySearch> createState() => _EmptySearchState();
}

class _EmptySearchState extends State<EmptySearch> {
  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      Image(
        image: AssetImage(AppAssets.iconEmptySearch),
      )
    ]);
  }
}

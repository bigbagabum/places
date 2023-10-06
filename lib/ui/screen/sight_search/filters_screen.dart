import 'package:flutter/material.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_theme.dart';
import 'package:places/ui/screen/sight_search/sight_search.dart';
import 'package:places/ui/screen/sight_search/sight_search_model.dart';

final Location redSquare = Location(55.989198, 37.601605);

RangeValues currentRangeValues = const RangeValues(0, 10000);

final haversineDistance = HaversineDistance();

Map<String, bool> setCategory = {
  'cafe': true,
  'restaurant': true,
  'other': true,
  'park': true,
  'museum': true,
  'hotel': true
};

//сбрасываем настройки
void setDefault() {
  setCategory.forEach((key, value) {
    setCategory[key] = true;
  });
}

//меняем статус по клику на иконку категории
void catClick(String catName) {
  setCategory[catName] = !setCategory[catName]!;
}

//Выбираем в список строк выбранные категории
List<String> choisedCategory() {
  List<String> selectedCategories = [];

  setCategory.forEach((category, isSelected) {
    if (isSelected) {
      selectedCategories.add(category);
    }
  });

  return selectedCategories;
}

//проверка входит ли место в нужный радиус поиска
bool isPlaceNear(Location checkPlace, Location centerPlace, double kmMax) {
  double distanceInMeter =
      haversineDistance.haversine(checkPlace, centerPlace, Unit.METER);
  return distanceInMeter <= currentRangeValues.end;
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  void _clickBack() {
    Navigator.pop(context, [choisedCategory(), currentRangeValues.end]);
  }

  @override
  void initState() {
    super.initState();
    searchPlace(redSquare.latitude, redSquare.longitude, currentRangeValues.end,
        choisedCategory(), "");
  }

  int filteredListLength = filteredSightsList.length;

  Widget isCheckedFilterItem(bool value) {
    return value
        ? const Image(image: AssetImage(AppAssets.iconTickChoice))
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 0,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _clickBack,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Image(
                    image: const AssetImage(AppAssets.iconBackScreen),
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
              const Spacer(),

              //обнулить фильтр
              TextButton(
                onPressed: () async {
                  setDefault();
                  await searchPlace(redSquare.latitude, redSquare.longitude,
                      currentRangeValues.end, choisedCategory(), "");

                  setState(() {});
                },
                child: const Text(AppStrings.clearFilter,
                    style: AppTypography.textGreen16),
              ),
            ],
          )),
      body: Column(
        children: [
          Text(AppStrings.categories,
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
              )
              // ),
              ),
          Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 25, right: 24),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                //клик на иконку отеля
                                await searchPlace(
                                    redSquare.latitude,
                                    redSquare.longitude,
                                    currentRangeValues.end,
                                    choisedCategory(),
                                    "");

                                catClick("hotel");

                                setState(() {});
                              },
                              child: Stack(
                                //фильтр Отелей
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(AppAssets.buttonHotel)),
                                  isCheckedFilterItem(setCategory['hotel']!)
                                ],
                              ),
                            ),
                            const Text(
                              AppStrings.typeHotel,
                              style: AppTypography.textText12regular,
                            ),
                            const SizedBox(
                                height:
                                    40), //добавляем разделитель между строками
                            InkWell(
                              onTap: () async {
                                //клик на иконку Парк

                                await searchPlace(
                                    redSquare.latitude,
                                    redSquare.longitude,
                                    currentRangeValues.end,
                                    choisedCategory(),
                                    "");

                                catClick('park');
                                setState(() {});
                              },
                              child: Stack(
                                // фильтр парков
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(AppAssets.buttonPark)),
                                  isCheckedFilterItem(setCategory['park']!),
                                ],
                              ),
                            ),
                            const Text(
                              AppStrings.typePark,
                              style: AppTypography.textText12regular,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 22, right: 22),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                await searchPlace(
                                    redSquare.latitude,
                                    redSquare.longitude,
                                    currentRangeValues.end,
                                    choisedCategory(),
                                    "");

                                catClick("restourant");

                                setState(() {});
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(
                                          AppAssets.buttonRestaurant)),
                                  isCheckedFilterItem(
                                      setCategory['restourant']!)
                                ],
                              ),
                            ),
                            const Text(
                              AppStrings.typeRestourant,
                              style: AppTypography.textText12regular,
                            ),
                            const SizedBox(
                                height:
                                    40), //добавляем разделитель между строками
                            InkWell(
                              onTap: () async {
                                await searchPlace(
                                    redSquare.latitude,
                                    redSquare.longitude,
                                    currentRangeValues.end,
                                    choisedCategory(),
                                    "");

                                catClick("museum");

                                setState(() {});
                              },
                              child: Stack(
                                // фильтр музея
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image:
                                          AssetImage(AppAssets.buttonMuseum)),
                                  isCheckedFilterItem(setCategory['museum']!)
                                ],
                              ),
                            ),
                            const Text(
                              AppStrings.typeMuseum,
                              style: AppTypography.textText12regular,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18, right: 25),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                await searchPlace(
                                    redSquare.latitude,
                                    redSquare.longitude,
                                    currentRangeValues.end,
                                    choisedCategory(),
                                    "");

                                catClick("other");

                                setState(() {});
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(
                                          AppAssets.buttonParticularPlace)),
                                  isCheckedFilterItem(setCategory['other']!)
                                ],
                              ),
                            ),
                            const Text(
                              AppStrings.typePartikularPlace,
                              style: AppTypography.textText12regular,
                            ),
                            const SizedBox(
                                height:
                                    40), //добавляем разделитель между строками
                            InkWell(
                              onTap: () async {
                                await searchPlace(
                                    redSquare.latitude,
                                    redSquare.longitude,
                                    currentRangeValues.end,
                                    choisedCategory(),
                                    "");

                                catClick("cafe");
                                setState(() {});
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(AppAssets.buttonCafe)),
                                  isCheckedFilterItem(setCategory['cafe']!)
                                ],
                              ),
                            ),
                            const Text(
                              AppStrings.typeCafe,
                              style: AppTypography.textText12regular,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 56),
                  Row(
                    children: [
                      const Text(AppStrings.distance,
                          style: AppTypography.textText16Regular),
                      const Spacer(),
                      Text(
                          'от ${currentRangeValues.start.round()} до ${currentRangeValues.end.round()} м.',
                          style: AppTypography.textText16Regular)
                    ],
                  ),
                ],
              )),
          RangeSlider(
              values: currentRangeValues,
              activeColor: Colors.green,
              inactiveColor: Colors.grey,
              max: 10000,
              // min: 100,
              divisions: 100,
              onChanged: (RangeValues values) async {
                setState(() {
                  currentRangeValues = values;
                });
                await searchPlace(redSquare.latitude, redSquare.longitude,
                    currentRangeValues.end, choisedCategory(), "");
              }),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            height: 48,
            width: 328,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
                onPressed: () {
                  Navigator.pop(
                      context, [choisedCategory, currentRangeValues.end]);
                },
                child: Text(
                  '${AppStrings.showFilteredList} ($filteredListLength)',
                  style: AppTypography.textText14bold,
                )),
          )
        ],
      ),
    );
  }
}

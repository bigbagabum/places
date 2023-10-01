// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_theme.dart';

final Location redSquare = Location(55.989198, 37.601605);

final haversineDistance = HaversineDistance();

bool isPlaceNear(Location checkPlace, Location centerPlace, kmMin, kmMax) {
  double distanceInMeter =
      haversineDistance.haversine(checkPlace, centerPlace, Unit.METER);
  return (_FiltersScreenState.currentRangeValues.start <= distanceInMeter) &&
      (distanceInMeter <= _FiltersScreenState.currentRangeValues.end);
}

List<Sight> fillListItems(List<Sight> value) {
  //Наполняем изначальными данными список мест
  List<Sight> filledList = [];
  for (var n in value) {
    if (isPlaceNear(
        redSquare,
        Location(n.lat, n.lng),
        _FiltersScreenState.currentRangeValues.start,
        _FiltersScreenState.currentRangeValues.end)) {
      filledList.add(n);
    }
  }
  return filledList;
}

class FilteresScreenSmallScreens extends StatefulWidget {
  const FilteresScreenSmallScreens({super.key});

  @override
  State<FilteresScreenSmallScreens> createState() =>
      _FilteresScreenSmallScreensState();
}

class _FilteresScreenSmallScreensState
    extends State<FilteresScreenSmallScreens> {
  void _clickBack() {
    Navigator.pop(context, filteredMockList);
  }

  int filteredListLength = fillListItems(mocks).length;

  List<Sight> filteredMockList =
      fillListItems(mocks); //наполняем первично лист с учетом удаленности

  void filterOfItems() {
    List<Sight> filteredPlaces = [];

    for (int e = 0; e < mocks.length; e++) {
      if (((mocks[e].type == 'hotel' && isHotel) ||
              (mocks[e].type == 'park' && isPark) ||
              (mocks[e].type == 'restaurant' && isRestourant) ||
              (mocks[e].type == 'other' && isParticularPlace) ||
              (mocks[e].type == 'museum' && isMuseum) ||
              (mocks[e].type == 'cafe' && isCafe)) &&
          isPlaceNear(
              redSquare,
              Location(mocks[e].lat, mocks[e].lng),
              _FiltersScreenState.currentRangeValues.start,
              _FiltersScreenState.currentRangeValues.end)) {
        filteredPlaces.add(mocks[e]);
      }
    }
    setState(() {
      filteredMockList = filteredPlaces;
      filteredListLength = filteredMockList.length;
    });
  }

  Widget isCheckedFilterItem(bool value) {
    return value
        ? const Image(image: AssetImage(AppAssets.iconTickChoice))
        : Container();
  }

  bool isHotel = true,
      isRestourant = true,
      isParticularPlace = true,
      isPark = true,
      isMuseum = true,
      isCafe = true;

  static RangeValues currentRangeValues = const RangeValues(500, 8000);

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
              TextButton(
                onPressed: () {
                  setState(() {
                    isHotel = true;
                    isPark = true;
                    isRestourant = true;
                    isMuseum = true;
                    isParticularPlace = true;
                    isCafe = true;
                    currentRangeValues = const RangeValues(100, 10000);
                    filterOfItems();
                  });
                },
                child: const Text(AppStrings.clearFilter,
                    style: AppTypography.textGreen16),
              ),
            ],
          )),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.categories,
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
              )
              // ),
              ),

          //контейнер с иконками фильтра
          Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 20),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isHotel = !isHotel;
                                  filterOfItems();
                                });
                              },
                              child: Stack(
                                //фильтр Отелей
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(AppAssets.buttonHotel)),
                                  isCheckedFilterItem(isHotel),
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
                              onTap: () {
                                setState(() {
                                  isPark = !isPark;
                                  filterOfItems();
                                });
                              },
                              child: Stack(
                                // фильтр парков
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(AppAssets.buttonPark)),
                                  isCheckedFilterItem(isPark),
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
                        margin: const EdgeInsets.only(left: 15, right: 20),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isRestourant = !isRestourant;
                                  filterOfItems();
                                });
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(
                                          AppAssets.buttonRestaurant)),
                                  isCheckedFilterItem(isRestourant)
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
                              onTap: () {
                                setState(() {
                                  isMuseum = !isMuseum;
                                  filterOfItems();
                                });
                              },
                              child: Stack(
                                // фильтр музея
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image:
                                          AssetImage(AppAssets.buttonMuseum)),
                                  isCheckedFilterItem(isMuseum)
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
                        padding: const EdgeInsets.only(left: 15, right: 0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isParticularPlace = !isParticularPlace;
                                  filterOfItems();
                                });
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(
                                          AppAssets.buttonParticularPlace)),
                                  isCheckedFilterItem(isParticularPlace)
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
                              onTap: () {
                                setState(() {
                                  isCafe = !isCafe;
                                  filterOfItems();
                                });
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(AppAssets.buttonCafe)),
                                  isCheckedFilterItem(isCafe)
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
              min: 100,
              divisions: 100,
              onChanged: (RangeValues values) {
                setState(() {
                  currentRangeValues = values;
                });
                filterOfItems();
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
                  Navigator.pop(context, filteredMockList);
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

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  void _clickBack() {
    Navigator.pop(context, filteredMockList);
  }

  int filteredListLength = fillListItems(mocks).length;

  List<Sight> filteredMockList =
      fillListItems(mocks); //наполняем первично лист с учетом удаленности

  void filterOfItems() {
    List<Sight> filteredPlaces = [];

    for (int e = 0; e < mocks.length; e++) {
      if (((mocks[e].type == 'hotel' && isHotel) ||
              (mocks[e].type == 'park' && isPark) ||
              (mocks[e].type == 'restaurant' && isRestourant) ||
              (mocks[e].type == 'other' && isParticularPlace) ||
              (mocks[e].type == 'museum' && isMuseum) ||
              (mocks[e].type == 'cafe' && isCafe)) &&
          isPlaceNear(
              redSquare,
              Location(mocks[e].lat, mocks[e].lng),
              _FiltersScreenState.currentRangeValues.start,
              _FiltersScreenState.currentRangeValues.end)) {
        filteredPlaces.add(mocks[e]);
      }
    }
    setState(() {
      filteredMockList = filteredPlaces;
      filteredListLength = filteredMockList.length;
    });
  }

  Widget isCheckedFilterItem(bool value) {
    return value
        ? const Image(image: AssetImage(AppAssets.iconTickChoice))
        : Container();
  }

  bool isHotel = true,
      isRestourant = true,
      isParticularPlace = true,
      isPark = true,
      isMuseum = true,
      isCafe = true;

  static RangeValues currentRangeValues = const RangeValues(500, 8000);

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
              TextButton(
                onPressed: () {
                  setState(() {
                    isHotel = true;
                    isPark = true;
                    isRestourant = true;
                    isMuseum = true;
                    isParticularPlace = true;
                    isCafe = true;
                    currentRangeValues = const RangeValues(100, 10000);
                    filterOfItems();
                  });
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
                              onTap: () {
                                //клик на иконку отеля
                                setState(() {
                                  isHotel = !isHotel;
                                  filterOfItems();
                                });
                              },
                              child: Stack(
                                //фильтр Отелей
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(AppAssets.buttonHotel)),
                                  isCheckedFilterItem(isHotel),
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
                              onTap: () {
                                //клик на иконку Парк
                                setState(() {
                                  isPark = !isPark;
                                  filterOfItems();
                                });
                              },
                              child: Stack(
                                // фильтр парков
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(AppAssets.buttonPark)),
                                  isCheckedFilterItem(isPark),
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
                              onTap: () {
                                setState(() {
                                  isRestourant = !isRestourant;
                                  filterOfItems();
                                });
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(
                                          AppAssets.buttonRestaurant)),
                                  isCheckedFilterItem(isRestourant)
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
                              onTap: () {
                                setState(() {
                                  isMuseum = !isMuseum;
                                  filterOfItems();
                                });
                              },
                              child: Stack(
                                // фильтр музея
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image:
                                          AssetImage(AppAssets.buttonMuseum)),
                                  isCheckedFilterItem(isMuseum)
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
                              onTap: () {
                                setState(() {
                                  isParticularPlace = !isParticularPlace;
                                  filterOfItems();
                                });
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(
                                          AppAssets.buttonParticularPlace)),
                                  isCheckedFilterItem(isParticularPlace)
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
                              onTap: () {
                                setState(() {
                                  isCafe = !isCafe;
                                  filterOfItems();
                                });
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  const Image(
                                      image: AssetImage(AppAssets.buttonCafe)),
                                  isCheckedFilterItem(isCafe)
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
              min: 100,
              divisions: 100,
              onChanged: (RangeValues values) {
                setState(() {
                  currentRangeValues = values;
                });
                filterOfItems();
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
                  Navigator.pop(context, filteredMockList);
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

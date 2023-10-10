import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_theme.dart';
import 'package:places/ui/screen/sight_card/sight_card.dart';
import 'package:places/ui/res/app_strings.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<VisitingScreen> createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final listKey = ValueKey;

  void cancelIconClick(Sight sight) {
    final PlaceRepository placeRepository = PlaceRepository();
    final PlaceInteractor placeInteractor = PlaceInteractor(placeRepository);

    setState(() {
      try {
        placeInteractor.removeFromFavorites(sight.sightId);
      } catch (error) {
        print('Error during download data from server: $error');
      }
    });
  }

  List<Widget> listOfSights(List<Sight> listSights, SightStatus statusSight) {
    List<Widget> list = [];
    for (int i = 0; i < listSights.length; i++) {
      if (listSights[i].status == statusSight) {
        list.add(SightCard(
          key: ValueKey(listSights[i].sightId),
          sight: listSights[i],
          listIndex: SightListIndex.planList,
          onDelete: () => cancelIconClick(listSights[i]),
        ));
      }
    }

    return list;
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = mocks.removeAt(oldIndex);
      mocks.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 52,
        //backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52.0),
          child: Center(
              child: Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: Theme.of(context).primaryColorDark,
            ),
            child: TabBar(
                controller: _controller,
                unselectedLabelColor: AppColors.darkGrey,
                labelColor: Theme.of(context).primaryColorDark,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: Theme.of(context).primaryColorLight),
                tabs: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45)),
                      child: const Center(
                          child: Text(
                        AppStrings.tabPlanned,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ))),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(45)),
                    child: const Center(
                        child: Text(
                      AppStrings.tabVisited,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )),
                  )
                ]),
          )),
        ),
        title: Center(
          child: Text(
            AppStrings.titleScreenFavorite,
            style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: TabBarView(controller: _controller, children: [
        ReorderableListView(
            onReorder: _onReorder,
            children: listOfSights(mocks, SightStatus.sightToVisit)),
        ReorderableListView(
          onReorder: _onReorder,
          children: listOfSights(mocks, SightStatus.sightVisited),
        ),
      ]),
    );
  }
}

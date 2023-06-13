//import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_theme.dart';
import 'package:places/ui/screen/sight_card.dart';
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

  void cancelIconClick(int index) {
    setState(() {
      mocks
          .firstWhere((itemToCancelFromVisitList) =>
              itemToCancelFromVisitList.sightId == index)
          .status = SightStatus.sightNoPlans;
    });
  }

  List<Widget> listOfSights(List<Sight> listSights, SightStatus statusSight) {
    List<Widget> list = [];
    for (int i = 0; i < listSights.length; i++) {
      if (listSights[i].status == statusSight) {
        list.add(SightCard(
          sight: listSights[i],
          listIndex: SightListIndex.planList,
          status: statusSight,
          //listKey: ValueKey(listSights[i].sightId),
          onDelete: () => cancelIconClick(listSights[i].sightId),
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
                    color: Theme.of(context).primaryColorLight
                    //color: AppColors.darkButton
                    ),
                tabs: [
                  Container(
                      decoration: BoxDecoration(
                          // color: AppColors.darkButton,
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
          // child: ,
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
        SingleChildScrollView(
          child:
              Column(children: listOfSights(mocks, SightStatus.sightToVisit)),
        ),
        SingleChildScrollView(
          child: Column(
            children: listOfSights(mocks, SightStatus.sightVisited),
          ),
        ),
      ]),
    );
  }
}

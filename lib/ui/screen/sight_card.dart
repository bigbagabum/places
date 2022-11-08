import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_theme.dart';

class TopIconWidget extends StatelessWidget {
  final dynamic status, listIndex;

  String _heartIconClick() {
    print('Heart icon Clicked');
    return '';
  }

  String _calendarIconClick() {
    print('Calendar Icon Click');
    return '';
  }

  String _cancelIconClick() {
    print('Cancel Buttun Clicked');
    return '';
  }

  String _routeIconClick() {
    print('Route Button Clicked');
    return '';
  }

  const TopIconWidget({Key? key, required this.status, required this.listIndex})
      : super(key: key);

  Widget _topIconRow() {
    switch (listIndex) {
      case SightListIndex.mainList:
        return GestureDetector(
          onTap: _heartIconClick,
          child: Image(
              image: AssetImage('lib/ui/res/icons/heart_icon.png'),
              color: AppColors.lightGrey),
        );
      case SightListIndex.planList:
        switch (status) {
          case SightStatus.sightNoPlans:
            break;

          case SightStatus
              .sightToVisit: // вид карточки в списке "Хочу посетить"
            return Row(children: [
              GestureDetector(
                onTap: _calendarIconClick,
                child: const Image(
                    image: AssetImage('lib/ui/res/icons/calendar.png'),
                    color: AppColors.lightGrey),
              ),
              GestureDetector(
                onTap: _cancelIconClick,
                child: const Image(
                    image: AssetImage('lib/ui/res/icons/cancel.png'),
                    color: AppColors.lightGrey),
              )
            ]);

          case SightStatus.sightVisited: // вид карточк в списке "посетил"
            return Row(children: [
              GestureDetector(
                  onTap: _routeIconClick,
                  child: const Image(
                      image: AssetImage('lib/ui/res/icons/way.png'))),
              GestureDetector(
                onTap: _cancelIconClick,
                child: const Image(
                    image: AssetImage('lib/ui/res/icons/cancel.png'),
                    color: AppColors.lightGrey),
              )
            ]);
        }
    }
    throw '';
  }

  @override
  Widget build(BuildContext context) {
    return _topIconRow();
  }
}

class BottomColumn extends StatelessWidget {
  final dynamic listIndex, status;
  final Sight sight;
  const BottomColumn(
      {Key? key, required this.sight, required this.listIndex, this.status})
      : super(key: key);

  Widget _bottomColumnData(context) {
    switch (listIndex) {
      case SightListIndex.mainList:
        return Text(sight.details,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14, color: Theme.of(context).primaryColorLight));
      case SightListIndex.planList:
        switch (status) {
          case SightStatus.sightToVisit:
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Запланировано на 01.01.23\n',
                      style: TextStyle(color: Colors.green)),
                  Text('Закрыто до 09:00',
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor))
                ]);
          case SightStatus.sightVisited:
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Цель достигнута 20.08.22\n',
                    style:
                        TextStyle(color: Theme.of(context).primaryColorLight),
                  ),
                  Text('открыто круглосуточно',
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      ))
                ]);
        }
    }
    throw '';
  }

  @override
  Widget build(BuildContext context) {
    return _bottomColumnData(context);
  }
}

class SightCard extends StatelessWidget {
  final Sight sight;
  // ignore: prefer_typing_uninitialized_variables
  final listIndex, status;
  const SightCard(
      {Key? key,
      required this.sight,
      required this.listIndex,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: AspectRatio(
          aspectRatio: 3 / 2,
          child: Container(
            margin: const EdgeInsets.all(15),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              //color: Colors.yellow,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            width: double.infinity,
            child: Column(
              children: [
                Flexible(
                    //flex: 1,
                    child: Container(
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                        child: Stack(clipBehavior: Clip.none, children: [
                          SizedBox(
                              width: double.infinity,
                              child: Image(
                                  image: AssetImage(sight.img),
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),

                                      //child
                                    );
                                  })),
                          Row(children: [
                            Container(
                                padding: const EdgeInsets.all(16),
                                alignment: Alignment.topLeft,
                                child: Text(sight.type,
                                    style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))),
                            const Spacer(),
                            Container(
                                padding: const EdgeInsets.all(16),
                                alignment: Alignment.topRight,
                                child:

                                    // смотрим в каком мы списке и отображаем нужные иконки справа сверху
                                    Row(
                                  children: [
                                    TopIconWidget(
                                      listIndex: listIndex,
                                      status: status,
                                    )
                                    //_topIconRow(),
                                  ],
                                ))
                          ])
                        ]))),
                Flexible(
                    //flex: 1,
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        //height: double.infinity,
                        width: double.infinity,
                        color: Theme.of(context).primaryColorDark,
                        child: Column(children: [
                          SizedBox(
                              height: 25,
                              width: double.infinity,
                              child: Text(sight.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      overflow: TextOverflow.clip,
                                      fontFamily: 'Roboto',
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontWeight: FontWeight.bold))),
                          SizedBox(
                              width: double.infinity,

                              //тут будет кастомная колонка отрисованная от выбранного списка
                              child: BottomColumn(
                                  sight: sight,
                                  listIndex: listIndex,
                                  status: status)),
                        ])))
              ],
            ),
          )),
    );
  }
}

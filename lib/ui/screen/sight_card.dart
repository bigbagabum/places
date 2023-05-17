import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_theme.dart';
import 'package:places/ui/screen/visiting_screen.dart';

class SightCard extends StatefulWidget {
  final Sight sight;
  final listIndex, status;
  final ValueKey listKey;
  final VoidCallback onDelete;

  const SightCard({
    Key? key,
    required this.sight,
    required this.listIndex,
    required this.status,
    required this.listKey,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<SightCard> createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  String _heartIconClick() {
    print('Heart icon Clicked');
    return '';
  }

  String _calendarIconClick() {
    print('Calendar Icon Click');
    return '';
  }

  // void _cancelIconClick(ValueKey index) {
  //   mocks
  //       .firstWhere((itemToCancelFromVisitList) =>
  //           itemToCancelFromVisitList.sightId == index)
  //       .status = SightStatus.sightNoPlans;
  //   print("выбран набор с индексом ${index.toString()}");

  // }

  String _routeIconClick() {
    print('Route Button Clicked');
    return '';
  }

  Widget _topIconRow() {
    switch (widget.listIndex) {
      case SightListIndex.mainList:
        return GestureDetector(
          onTap: _heartIconClick,
          child: Image(
            image: AssetImage('lib/ui/res/icons/heart_icon.png'),
            color: AppColors.lightGrey,
          ),
        );
      case SightListIndex.planList:
        switch (widget.status) {
          case SightStatus.sightNoPlans:
            break;

          case SightStatus.sightToVisit:
            return Row(
              children: [
                GestureDetector(
                  onTap: _calendarIconClick,
                  child: const Image(
                    image: AssetImage('lib/ui/res/icons/calendar.png'),
                    color: AppColors.lightGrey,
                  ),
                ),
                GestureDetector(
                  // onTap: () => _cancelIconClick(widget.listKey),
                  child: const Image(
                    image: AssetImage('lib/ui/res/icons/cancel.png'),
                    color: AppColors.lightGrey,
                  ),
                ),
              ],
            );

          case SightStatus.sightVisited:
            return Row(
              children: [
                GestureDetector(
                  onTap: _routeIconClick,
                  child: const Image(
                    image: AssetImage('lib/ui/res/icons/way.png'),
                  ),
                ),
                GestureDetector(
                  key: widget.listKey,
                  //onTap: () => _cancelIconClick(widget.listKey),
                  onTap: () => widget.onDelete,
                  child: const Image(
                    image: AssetImage('lib/ui/res/icons/cancel.png'),
                    color: AppColors.lightGrey,
                  ),
                ),
              ],
            );
        }
    }
    throw '';
  }

  Widget _bottomColumnData(BuildContext context) {
    switch (widget.listIndex) {
      case SightListIndex.mainList:
        return Text(
          widget.sight.details,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).primaryColorLight,
          ),
        );
      case SightListIndex.planList:
        switch (widget.status) {
          case SightStatus.sightToVisit:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Запланировано на 01.01.23\n',
                  style: TextStyle(color: Colors.green),
                ),
                Text(
                  'Закрыто до 09:00',
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ],
            );
          case SightStatus.sightVisited:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Цель достигнута 20.08.22\n',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                Text(
                  'открыто круглосуточно',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ],
            );
        }
    }
    throw '';
  }

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
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          width: double.infinity,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Image(
                          image: AssetImage(widget.sight.img),
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.sight.type,
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.topRight,
                            child: Row(
                              children: [
                                _topIconRow(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  color: Theme.of(context).primaryColorDark,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                        width: double.infinity,
                        child: Text(
                          widget.sight.name,
                          style: TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.clip,
                            fontFamily: 'Roboto',
                            color: Theme.of(context).primaryColorLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: _bottomColumnData(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

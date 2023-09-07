import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_theme.dart';
import 'package:places/ui/screen/sight_details/sight_details.dart';

class SightCard extends StatefulWidget {
  final Sight sight;
  final dynamic listIndex;
  final VoidCallback? onDelete;

  const SightCard({
    Key? key,
    required this.sight,
    required this.listIndex,
    this.onDelete,
  }) : super(key: key);

  @override
  State<SightCard> createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  String _heartIconClick() {
    return '';
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _calendarIconClick(BuildContext context) async {
    final DateTime? selectDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2024),
    );

    if (selectDate != null) {
      setState(() {
        selectedDate = selectDate;
      });
    }
  }

  String _routeIconClick() {
    return '';
  }

  Widget _topIconRow() {
    switch (widget.listIndex) {
      case SightListIndex.mainList:
        return GestureDetector(
          onTap: _heartIconClick,
          child: const Image(
            image: AssetImage(AppAssets.iconHeart),
            color: AppColors.lightGrey,
          ),
        );
      case SightListIndex.planList:
        switch (widget.sight.status) {
          case SightStatus.sightNoPlans:
            break;

          case SightStatus.sightToVisit:
            return Row(
              children: [
                GestureDetector(
                  onTap: () => _calendarIconClick(context),
                  child: const Image(
                    image: AssetImage(AppAssets.iconCalendar),
                    color: AppColors.lightGrey,
                  ),
                ),
                GestureDetector(
                  onTap: () => widget.onDelete?.call(),
                  child: const Image(
                    image: AssetImage(AppAssets.iconDelete),
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
                    image: AssetImage(AppAssets.iconWay),
                  ),
                ),
                GestureDetector(
                  onTap: () => widget.onDelete?.call(),
                  child: const Image(
                    image: AssetImage(AppAssets.iconDelete),
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
          maxLines: 7,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).primaryColorLight,
          ),
        );
      case SightListIndex.planList:
        switch (widget.sight.status) {
          case SightStatus.sightToVisit:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.planDate,
                  style: TextStyle(color: Colors.green),
                ),
                Text(
                  AppStrings.openTime,
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
                  AppStrings.visitedDate,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                Text(
                  AppStrings.openTime24,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ],
            );
          case SightStatus.sightNoPlans:
            break;
        }
    }
    throw '';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            backgroundColor: Colors.transparent.withOpacity(0.5),
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: SightDetails(detailSight: widget.sight));
            },
          );
        },
        child: AspectRatio(
          aspectRatio: 3 / 2,
          child: Dismissible(
            direction: widget.listIndex == SightListIndex.mainList
                ? DismissDirection.none
                : DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              child: const Image(image: AssetImage(AppAssets.deletefromList)),
            ),
            key: ValueKey(widget.sight.sightId),
            onDismissed: (_) => widget.onDelete?.call(),
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
                        clipBehavior: Clip.hardEdge,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Image(
                              image: AssetImage(widget.sight.img[0]),
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
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
                              style: Theme.of(context).textTheme.titleLarge,
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
        ));
  }
}

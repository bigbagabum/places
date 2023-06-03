import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_theme.dart';

class SightCard extends StatefulWidget {
  final Sight sight;
  final dynamic listIndex, status;
  final ValueKey listKey;
  final VoidCallback? onDelete;

  const SightCard({
    Key? key,
    required this.sight,
    required this.listIndex,
    required this.status,
    required this.listKey,
    this.onDelete,
  }) : super(key: key);

  @override
  State<SightCard> createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  String _heartIconClick() {
    return '';
  }

  String _calendarIconClick() {
    return '';
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
        switch (widget.status) {
          case SightStatus.sightNoPlans:
            break;

          case SightStatus.sightToVisit:
            return Row(
              children: [
                GestureDetector(
                  onTap: _calendarIconClick,
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

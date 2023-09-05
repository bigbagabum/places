import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/sight_details/sight_details_model.dart';

class SightDetails extends StatefulWidget {
  final Sight detailSight;
  const SightDetails({Key? key, required this.detailSight}) : super(key: key);

  @override
  State<SightDetails> createState() => _SightDetailsState();
}

class _SightDetailsState extends State<SightDetails> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 150,
            child: CustomScrollView(
              slivers: [
                //сворачиваемая часть

                SliverAppBar(
                  pinned: false,
                  automaticallyImplyLeading: false,
                  expandedHeight: 300,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        ImageGallery(imgList: widget.detailSight.img),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(
                                context,
                                (route) =>
                                    route.settings.name == 'home_tab_screen');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25))),
                                    margin: const EdgeInsets.only(
                                        left: 16, top: 36),
                                    child: Image(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        image: const AssetImage(
                                            AppAssets.cancel))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // прокручиваемая часть
                SliverToBoxAdapter(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 16, top: 16, right: 16),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: double.infinity,
                    child: Text(
                      widget.detailSight.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Theme.of(context).primaryColorLight,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          widget.detailSight.type,
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).primaryColorLight,
                              fontFamily: 'Roboto'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            AppStrings.open24,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: const EdgeInsets.only(
                        right: 16, top: 16, left: 16, bottom: 30),
                    width: double.infinity,
                    child: Text(
                      widget.detailSight.details,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //to top level of stack
          Positioned(
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 21, bottom: 16),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                children: [
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Container(
                      height: 48,
                      width: 328,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Colors.green),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: const Image(
                                image: AssetImage(AppAssets.wayToSight),
                              ),
                            ),
                            Text(
                              AppStrings.builtRoute,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 328,
                    height: 1,
                    color: const Color.fromRGBO(124, 126, 146, 0.56),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            //width: 164,
                            height: 40,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    image: const AssetImage(
                                        AppAssets.iconCalendar),
                                    color: Theme.of(context).primaryColorLight),
                                Text(
                                  AppStrings.getPlan,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          Theme.of(context).primaryColorLight),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    image:
                                        const AssetImage(AppAssets.iconHeart),
                                    color: Theme.of(context).primaryColorLight),
                                Text(
                                  AppStrings.inFavorite,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          Theme.of(context).primaryColorLight),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

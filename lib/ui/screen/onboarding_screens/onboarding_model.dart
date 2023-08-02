import 'package:flutter/material.dart';
import 'package:places/ui/res/app_assets.dart';
import 'package:places/ui/res/app_strings.dart';

List<OnBoardingPageModel> onBoardingScreens = [
  OnBoardingPageModel(AppAssets.tutorialIcon1, AppStrings.tutorialTextTitle1,
      AppStrings.tutorialTextSubtitle1),
  OnBoardingPageModel(AppAssets.tutorialIcon2, AppStrings.tutorialTextTitle2,
      AppStrings.tutorialTextSubtitle2),
  OnBoardingPageModel(AppAssets.tutorialIcon3, AppStrings.tutorialTextTitle3,
      AppStrings.tutorialTextSubtitle3)
];

class OnBoardingPageModel {
  final String topText, bottomText, imgURL;
  OnBoardingPageModel(this.imgURL, this.topText, this.bottomText);
}

class OnBoardingPageItem extends StatefulWidget {
  final OnBoardingPageModel pageItem;
  final int currentPage;
  const OnBoardingPageItem(
      {super.key, required this.pageItem, required this.currentPage});

  @override
  State<OnBoardingPageItem> createState() => _OnBoardingPageItemState();
}

class _OnBoardingPageItemState extends State<OnBoardingPageItem> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 40,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ((widget.currentPage + 1) == onBoardingScreens.length)
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(AppStrings.skip,
                          style: Theme.of(context).textTheme.bodyText1)),
                ),
        ],
      ),
      const SizedBox(
        height: 200,
      ),
      Image(image: AssetImage(widget.pageItem.imgURL)),
      Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Text(
          widget.pageItem.topText,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Text(
          widget.pageItem.bottomText,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      const Spacer(),
      ((widget.currentPage + 1) == onBoardingScreens.length)
          ? GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).selectedRowColor,
                    borderRadius: BorderRadius.circular(10)),
                height: 48,
                width: 328,
                child: Center(
                  child: Text(
                    AppStrings.tutorialTextButton3,
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ),
            )
          : Container()
    ]);
  }
}

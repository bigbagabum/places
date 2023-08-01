import 'package:flutter/material.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/onboarding_screens/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboaardingScreen extends StatefulWidget {
  const OnboaardingScreen({super.key});

  @override
  State<OnboaardingScreen> createState() => _OnboaardingScreenState();
}

class _OnboaardingScreenState extends State<OnboaardingScreen> {
  final PageController controller = PageController(initialPage: 0);

  double currentPage = 0; // Переменная для хранения текущей страницы

  @override
  void initState() {
    super.initState();
    // Используем addListener, чтобы получать актуальное значение текущей страницы
    controller.addListener(() {
      setState(() {
        currentPage = controller.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 600,
            child: PageView.builder(
              controller: controller,
              itemCount: onBoardingScreens.length,
              itemBuilder: (context, index) {
                return OnBoardingPageItem(
                  pageItem: onBoardingScreens[index],
                  currentPage: index,
                );
              },
            ),
          ),
          SmoothPageIndicator(
              controller: controller,
              count: onBoardingScreens.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.green,
              )),
          const Spacer(),
          (currentPage == (onBoardingScreens.length - 1))
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
                ))
              : Container()
        ],
      ),
    );
  }
}

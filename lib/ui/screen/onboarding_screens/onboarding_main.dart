import 'package:flutter/material.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/onboarding_screens/welcome_screens.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboaardingScreen extends StatefulWidget {
  const OnboaardingScreen({super.key});

  @override
  State<OnboaardingScreen> createState() => _OnboaardingScreenState();
}

class _OnboaardingScreenState extends State<OnboaardingScreen> {
  final controller = PageController();

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
        ],
      ),
    );
  }
}

class LinearOnboardIndicator extends StatefulWidget {
  const LinearOnboardIndicator({super.key});

  @override
  State<LinearOnboardIndicator> createState() => _LinearOnboardIndicatorState();
}

class _LinearOnboardIndicatorState extends State<LinearOnboardIndicator> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

import 'package:flutter/material.dart';
import 'package:places/ui/screen/onboarding_screens/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboaardingScreen extends StatefulWidget {
  const OnboaardingScreen({super.key});

  @override
  State<OnboaardingScreen> createState() => _OnboaardingScreenState();
}

class _OnboaardingScreenState extends State<OnboaardingScreen> {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
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
          Positioned(
            top: MediaQuery.of(context).size.height * 0.75,
            left: MediaQuery.of(context).size.width * 0.5 - 40,
            child: SmoothPageIndicator(
                controller: controller,
                count: onBoardingScreens.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.green,
                )),
          ),
        ],
      ),
    );
  }
}

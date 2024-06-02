import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/on_boarding/views/widgets/first_page.dart';
import 'package:todo_app/features/on_boarding/views/widgets/second_page.dart';
import '../../../core/res/colours.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.darkBackground,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              children: const [FirstPage(), SecondPage()],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15)
                  .copyWith(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.bounceInOut,
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Ionicons.chevron_forward_circle,
                          size: 30,
                          color: Colours.light,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colours.light,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 2,
                    effect: WormEffect(
                      dotHeight: 12,
                      dotWidth: 15,
                      spacing: 10,
                      dotColor: Colours.yellow.withOpacity(0.5),
                      activeDotColor: Colours.light,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

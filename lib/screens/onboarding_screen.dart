import 'dart:math';

import 'package:animation_flutter/models/onboarding.dart';
import 'package:animation_flutter/util/arc_painter.dart';
import 'package:animation_flutter/widgets/dot_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          // Note: Sensitivity is integer used when you don't want to mess up vertical drag
          _handleSwipePage(details);
        },
        child: Stack(
          children: [
            SizedBox(
              height: screenSize.height / 1.9,
              width: screenSize.width,
              child: CustomPaint(
                painter: ArcPainter(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 28.0),
                  child: Lottie.asset(
                    tabs[_currentIndex].lottieFile,
                    key: Key('${Random().nextInt(999999999)}'),
                    width: 600,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 270,
                child: Column(
                  children: [
                    Flexible(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: tabs.length,
                        itemBuilder: (BuildContext context, int index) {
                          OnboardingModel tab = tabs[index];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                tab.title,
                                style: const TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                tab.subtitle,
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white70,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        },
                        onPageChanged: (value) {
                          _currentIndex = value;
                          setState(() {});
                        },
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int index = 0; index < tabs.length; index++)
                          DotIndicator(isSelected: index == _currentIndex),
                      ],
                    ),
                    const SizedBox(height: 75)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _handleChangePage();
          });
        },
        backgroundColor: Colors.transparent,
        child: const Icon(CupertinoIcons.chevron_right, color: Colors.white),
      ),
    );
  }

  _handleChangePage() {
    if (_currentIndex == 2) {
      _pageController.animateToPage(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }

  void _handleSwipePage(DragUpdateDetails details) {
    int sensitivity = 8;
    if (details.delta.dx > sensitivity) {
      _previousPage();
    } else if (details.delta.dx < -sensitivity) {
      _nextPage();
    }
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );

    if (_currentIndex == 2) {
      _pageController.animateToPage(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }
}

import 'package:fake_store/core/widgets/custom_button.dart';
import 'package:fake_store/features/auth/presentation/views/login_view.dart';
import 'package:fake_store/features/on_boarding/presentation/views/widgets/dot_section.dart';
import 'package:fake_store/features/on_boarding/presentation/views/widgets/on_boarding_item.dart';
import 'package:flutter/material.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  List<Widget> screens = [
    OnBoardingItem(
      description:
          'From gadgets to fashion and home essentials—explore thousands of products in one place.',
      animation: 'assets/lotties/Shopping.json',
      title: 'Welcome All You Want, One App.',
    ),
    OnBoardingItem(
      description:
          'Get your orders delivered quickly with real-time tracking and trusted service.',

      animation: 'assets/lotties/onBoardingLottie1.json',
      title: 'Fast & Reliable Delivery Track. Receive. Repeat.',
    ),
    OnBoardingItem(
      description:
          'Tailored suggestions, secure payments, and a seamless shopping experience.',

      animation: 'assets/lotties/onBoardingLottie2.json',
      title: 'Smooth & Smart Shopping Smart Picks. Easy Checkout.',
    ),
  ];
  late PageController _pageController;
  int currentPage = 0;
  void initState() {
    _pageController = PageController();

    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          itemBuilder: (context, index) {
            return screens[index];
          },
          itemCount: screens.length,
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.03,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Builder(
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 15,
                  children: [
                    DotSection(pageIndex: currentPage),

                    CustomButton(
                      title: 'Next',
                      onPressed: () {
                        if (currentPage == 2) {
                          Navigator.pushReplacementNamed(
                            context,
                            LoginView.routeName,
                          );
                        } else {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, LoginView.routeName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Skip',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

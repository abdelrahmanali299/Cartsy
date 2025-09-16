import 'package:fake_store/constant.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/features/layout/presentation/views/layout_view.dart';
import 'package:fake_store/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  bool isloged = SharedPreferencesSinglton.getBool(isLogedIn);
  AnimationController? _controller;
  Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: Offset(0, 1), // من الأسفل
      end: Offset(0, 0), // إلى الوسط
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));

    _controller!.forward();
    Future.delayed(Duration(seconds: 2), () {
      isloged
          ? Navigator.pushReplacementNamed(context, LayoutView.routeName)
          : Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        Lottie.asset('assets/lotties/splash.json', fit: BoxFit.fill),
        SlideTransition(
          position: _animation!,
          child: Text(
            'Cartsy',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:fake_store/features/on_boarding/presentation/views/widgets/dot.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselWithDots extends StatefulWidget {
  const CarouselWithDots({super.key});

  @override
  State<CarouselWithDots> createState() => _CarouselWithDotsState();
}

class _CarouselWithDotsState extends State<CarouselWithDots> {
  late CarouselSliderController _controller;
  int activeIndex = 0;

  final List<String> images = [
    'assets/images/slider_img.jpg',
    'assets/images/slider1.jpg',
    'assets/images/slider2.jpg',
  ];
  @override
  void initState() {
    _controller = CarouselSliderController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider.builder(
          carouselController: _controller,
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: Image.asset(
                images[index],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          },
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() => activeIndex = index);
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
            (index) => Dot(isSelected: index == activeIndex),
          ),
        ),
      ],
    );
  }
}

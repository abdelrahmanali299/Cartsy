import 'package:fake_store/features/on_boarding/presentation/views/widgets/dot.dart';
import 'package:flutter/material.dart';

class DotSection extends StatelessWidget {
  const DotSection({super.key, required this.pageIndex});
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5,
      children: List.generate(3, (index) {
        return Dot(isSelected: pageIndex == index);
      }),
    );
  }
}

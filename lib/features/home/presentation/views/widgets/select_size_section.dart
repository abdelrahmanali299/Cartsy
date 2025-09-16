import 'package:fake_store/features/home/presentation/views/widgets/sizes_types.dart';
import 'package:flutter/material.dart';

class SelectSizeSection extends StatelessWidget {
  const SelectSizeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Size',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizesTypes(),
      ],
    );
  }
}

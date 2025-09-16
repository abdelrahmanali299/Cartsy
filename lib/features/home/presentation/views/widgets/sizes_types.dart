import 'package:flutter/material.dart';

class SizesTypes extends StatefulWidget {
  const SizesTypes({super.key});

  @override
  State<SizesTypes> createState() => _SizesTypesState();
}

class _SizesTypesState extends State<SizesTypes> {
  List<String> sizes = const ['S', 'M', 'L', 'XL', 'XXL'];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 30,
      children: List.generate(
        sizes.length,
        (index) => Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
                border: Border.all(
                  color: currentIndex == index ? Colors.blue : Colors.grey,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 5,
                    ),
                    child: Text(sizes[index], style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

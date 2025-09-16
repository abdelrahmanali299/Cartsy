import 'package:flutter/material.dart';

class ProductSearchItem extends StatelessWidget {
  const ProductSearchItem({
    super.key,
    required this.title,
    required this.image,
    this.date,
  });
  final String title;
  final String image;
  final String? date;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[300],
            ),
            child: Image.network(image),
          ),
        ),
        Expanded(
          flex: 5,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                const TextSpan(text: '\n'),
                date == null
                    ? const TextSpan()
                    : TextSpan(
                        text: '$date',
                        style: TextStyle(
                          color: Colors.blue,
                          // fontSize: 14,s
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

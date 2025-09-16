import 'package:fake_store/features/home/data/models/rating_model.dart';
import 'package:flutter/material.dart';

class ProductRateSection extends StatelessWidget {
  const ProductRateSection({super.key, required this.ratingModel});
  final RatingModel ratingModel;
  @override
  Widget build(BuildContext context) {
    double percentage = ratingModel.rate / 5;
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(
              '${ratingModel.rate} / 5',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '${ratingModel.count} reviews',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        SizedBox(height: 8),
        Expanded(
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 10,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              percentage >= 0.7 ? Colors.green : Colors.orange,
            ),
          ),
        ),
      ],
    );
  }
}

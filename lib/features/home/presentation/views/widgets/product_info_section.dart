import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),

        color: Colors.grey.withValues(alpha: .05),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    maxLines: 1,
                    productModel.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),

                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Text('${productModel.rating.rate} ⭐'),
              ],
            ),
          ),
          Expanded(
            child: Text(
              productModel.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Text(
                  '${productModel.price} \$',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  '57 \$',
                  style: TextStyle(
                    fontSize: 18,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

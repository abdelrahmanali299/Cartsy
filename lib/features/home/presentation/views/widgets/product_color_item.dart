import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductColorItem extends StatelessWidget {
  const ProductColorItem({
    super.key,
    required this.productModel,
    required this.productColor,
    required this.isDefaultColor,
    required this.isSelected,
  });
  final ProductModel productModel;
  final Color productColor;
  final bool isDefaultColor;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? Border.all(color: Colors.blue, width: 2.5) : null,
        color: Colors.grey[300],
      ),
      child: isDefaultColor
          ? Image.network(productModel.image)
          : ColorFiltered(
              colorFilter: ColorFilter.mode(productColor, BlendMode.modulate),
              child: Image.network(productModel.image),
            ),
    );
  }
}

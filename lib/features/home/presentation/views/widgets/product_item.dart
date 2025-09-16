import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:fake_store/features/home/presentation/views/widgets/product_image_section.dart';
import 'package:fake_store/features/home/presentation/views/widgets/product_info_section.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.productModel,
    required this.index,
  });
  final ProductModel productModel;
  final int index;
  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: ProductImageSection(
            productModel: widget.productModel,
            index: widget.index,
          ),
        ),
        Expanded(
          flex: 2,
          child: ProductInfoSection(productModel: widget.productModel),
        ),
      ],
    );
  }
}

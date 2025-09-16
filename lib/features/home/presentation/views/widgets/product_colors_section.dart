import 'package:fake_store/constant.dart';
import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:fake_store/features/home/presentation/views/widgets/product_color_item.dart';
import 'package:flutter/material.dart';

class ProductColorsSection extends StatefulWidget {
  const ProductColorsSection({
    super.key,
    required this.productModel,
    required this.controller,
  });
  final ProductModel productModel;
  final PageController controller;
  @override
  State<ProductColorsSection> createState() => _ProductColorsSectionState();
}

class _ProductColorsSectionState extends State<ProductColorsSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10,
        children: List.generate(
          productColors.length,
          (index) => GestureDetector(
            onTap: () {
              widget.controller.animateToPage(
                index,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
            child: ProductColorItem(
              isSelected: index == (widget.controller.page?.round() ?? 0),
              isDefaultColor: index == 0,
              productColor: productColors[index],
              productModel: widget.productModel,
            ),
          ),
        ),
      ),
    );
  }
}

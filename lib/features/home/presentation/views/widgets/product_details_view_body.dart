import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:fake_store/features/home/presentation/views/widgets/add_to_cart_section.dart';
import 'package:fake_store/features/home/presentation/views/widgets/show_product.dart';
import 'package:flutter/material.dart';

class ProductDetailsViewBody extends StatefulWidget {
  const ProductDetailsViewBody({
    super.key,
    required this.productModel,
    this.index,
  });
  final ProductModel productModel;
  final int? index;
  @override
  State<ProductDetailsViewBody> createState() => _ProductDetailsViewBodyState();
}

class _ProductDetailsViewBodyState extends State<ProductDetailsViewBody> {
  late PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ShowProduct(
            index: widget.index,
            productModel: widget.productModel,
            controller: (value) {
              pageController = value;
            },
          ),
        ),

        AddToCartSection(productModel: widget.productModel),
      ],
    );
  }
}

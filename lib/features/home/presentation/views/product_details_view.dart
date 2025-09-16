import 'package:fake_store/core/functions/custom_app_bar.dart';
import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:fake_store/features/home/presentation/views/widgets/product_details_view_body.dart';
import 'package:flutter/material.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.productModel, this.index});
  final ProductModel productModel;
  static const String routeName = '/product_details';
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Details', context, isLeading: true),
      body: SafeArea(
        child: ProductDetailsViewBody(productModel: productModel, index: index),
      ),
    );
  }
}

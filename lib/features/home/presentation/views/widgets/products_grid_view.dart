import 'package:fake_store/features/cart/presentation/manager/cubits/cart/cart_cubit.dart';
import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:fake_store/features/home/presentation/views/product_details_view.dart';
import 'package:fake_store/features/home/presentation/views/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGridView extends StatefulWidget {
  const ProductsGridView({
    super.key,
    required this.products,
    this.categoryName,
  });
  final List<ProductModel> products;
  final String? categoryName;

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().readDataFromCart();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = widget.categoryName == null
        ? widget.products
        : widget.products
              .where((e) => e.category == widget.categoryName)
              .toList();

    return SliverGrid.builder(
      itemCount: filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.6,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final product = filteredProducts[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ProductDetailsView.routeName,
                arguments: {'product': product, 'index': index},
              );
            },
            child: ProductItem(productModel: product, index: index),
          ),
        );
      },
    );
  }
}

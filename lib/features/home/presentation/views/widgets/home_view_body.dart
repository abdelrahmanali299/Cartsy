import 'package:fake_store/core/functions/custom_snack_bar.dart';
import 'package:fake_store/features/cart/presentation/manager/cubits/cart/cart_cubit.dart';
import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:fake_store/features/home/presentation/manager/cubits/filter_products_cubit.dart';
import 'package:fake_store/features/home/presentation/views/widgets/category_list_view.dart';
import 'package:fake_store/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:fake_store/features/home/presentation/views/widgets/products_grid_view.dart';
import 'package:fake_store/features/home/presentation/views/widgets/search_section.dart';
import 'package:fake_store/features/home/presentation/views/widgets/slider_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key, required this.products});
  final List<ProductModel> products;
  static bool isAdded = false;
  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is AddCartSuccess) {
          customSnackBar(context, 'Added to cart', Colors.green);
        } else if (state is AddCartError) {
          customSnackBar(context, state.message, Colors.red);
        } else if (state is DeleteCartSuccess) {
          customSnackBar(context, 'Deleted', Colors.green);
        } else if (state is DeleteCartError) {
          customSnackBar(context, state.message, Colors.red);
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: CustomHomeAppBar()),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(child: SearchSection()),
          SliverToBoxAdapter(child: CarouselWithDots()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10)),

          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.1,
              child: CategoryListView(
                onCategoryChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          BlocListener<FilterProductsCubit, FilterProductsState>(
            listener: (context, state) {
              if (state is FilterProductsSuccess) {
                widget.products.clear();
                widget.products.addAll(state.products);
                setState(() {});
              }
            },
            child: ProductsGridView(
              products: widget.products,
              categoryName: selectedCategory != 'All' ? selectedCategory : null,
            ),
          ),
        ],
      ),
    );
  }
}

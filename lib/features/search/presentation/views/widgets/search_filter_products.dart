import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:fake_store/features/home/presentation/views/product_details_view.dart';
import 'package:fake_store/features/search/presentation/manager/search/search_cubit.dart';
import 'package:fake_store/features/search/presentation/views/widgets/product_search_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFilterProducts extends StatelessWidget {
  const SearchFilterProducts({
    super.key,
    required this.filterProducts,
    required this.date,
  });
  final List<ProductModel> filterProducts;
  final ValueChanged<String> date;
  @override
  Widget build(BuildContext context) {
    final recentProducts = context.watch<SearchCubit>().recentProducts;
    return ListView.builder(
      itemCount: filterProducts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (recentProducts.contains(filterProducts[index])) {
              recentProducts.remove(filterProducts[index]);
              recentProducts.add(filterProducts[index]);
            } else {
              recentProducts.add(filterProducts[index]);
            }
            date(
              '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
            );
            Navigator.pushNamed(
              context,
              ProductDetailsView.routeName,
              arguments: {'product': filterProducts[index]},
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ProductSearchItem(
              title: filterProducts[index].title,
              image: filterProducts[index].image,
            ),
          ),
        );
      },
    );
  }
}

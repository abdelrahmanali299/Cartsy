import 'package:fake_store/features/home/presentation/views/product_details_view.dart';
import 'package:fake_store/features/search/presentation/manager/search/search_cubit.dart';
import 'package:fake_store/features/search/presentation/views/widgets/product_search_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentSearchListView extends StatelessWidget {
  const RecentSearchListView({super.key, this.searchDate});

  final String? searchDate;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<SearchCubit>(),
      child: Builder(
        builder: (context) {
          var recentSearchList = context.watch<SearchCubit>().recentProducts;
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: recentSearchList.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ProductDetailsView.routeName,
                          arguments: {'product': recentSearchList[index]},
                        );
                      },
                      child: ProductSearchItem(
                        date: searchDate,
                        title:
                            recentSearchList[recentSearchList.length -
                                    index -
                                    1]
                                .title,
                        image:
                            recentSearchList[recentSearchList.length -
                                    index -
                                    1]
                                .image,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      context.read<SearchCubit>().deleteOneRecentProduct(
                        index: index,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Icon(Icons.clear, size: 16, color: Colors.blue),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

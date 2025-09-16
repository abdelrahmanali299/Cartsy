import 'package:fake_store/core/functions/show_filter_options.dart';
import 'package:fake_store/features/layout/presentation/manager/cubits/change_pages/change_body_of_home_view_cubit.dart';
import 'package:fake_store/features/home/presentation/manager/cubits/filter_products_cubit.dart';
import 'package:fake_store/features/home/presentation/manager/cubits/get_all_products_cubit.dart';
import 'package:fake_store/features/home/presentation/views/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<FilterProductsCubit>(context),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Row(
          spacing: 10,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context
                      .read<ChangeBodyOfHomeViewCubit>()
                      .changeBodyOfHomeView(2);
                },
                child: SearchTextField(),
              ),
            ),
            GestureDetector(
              onTap: () {
                final filterProductsCubit = context.read<FilterProductsCubit>();
                filterProductsCubit.products = context
                    .read<GetAllProductsCubit>()
                    .productsList;
                showFilterOptions(
                  context,
                  filterProductsCubit: filterProductsCubit,
                );
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue,
                ),
                child: Icon(Icons.filter_list, color: Colors.white, size: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

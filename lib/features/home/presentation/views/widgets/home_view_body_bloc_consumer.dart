import 'package:fake_store/core/functions/get_dummy_products.dart';
import 'package:fake_store/features/home/presentation/manager/cubits/get_all_products_cubit.dart';
import 'package:fake_store/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeViewBodyBlocConsumer extends StatelessWidget {
  const HomeViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAllProductsCubit, GetAllProductsState>(
      builder: (context, state) {
        if (state is GetAllProductsLoading) {
          return Skeletonizer(
            child: HomeViewBody(products: getDummyProducts()),
          );
        }
        if (state is GetAllProductsSuccess) {
          return HomeViewBody(products: state.products);
        }
        return HomeViewBody(products: getDummyProducts());
      },
      listener: (context, state) {
        if (state is GetAllProductsFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
    );
  }
}

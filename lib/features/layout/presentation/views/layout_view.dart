import 'package:fake_store/core/api/end_points.dart';
import 'package:fake_store/features/home/data/repos/product_repo_impl.dart';
import 'package:fake_store/features/home/presentation/manager/cubits/get_all_products_cubit.dart';
import 'package:fake_store/features/home/presentation/manager/cubits/notification_cubit.dart';
import 'package:fake_store/features/layout/presentation/manager/cubits/change_pages/change_body_of_home_view_cubit.dart';
import 'package:fake_store/features/order/presentation/manager/cubits/order_cubit.dart';
import 'package:fake_store/features/profile/presentation/manager/cubits/get_single_user/get_single_user_cubit.dart';
import 'package:fake_store/features/search/presentation/manager/search/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});
  static const routeName = '/layout';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetSingleUserCubit()..getSingleUser(),
        ),
        BlocProvider(create: (context) => OrderCubit()),
        BlocProvider(create: (context) => ChangeBodyOfHomeViewCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => NotificationCubit()),

        BlocProvider(
          create: (context) =>
              GetAllProductsCubit(ProductRepoImpl())
                ..getAllProducts(path: EndPoints.products),
        ),
      ],
      child: Builder(
        builder: (context) {
          int currentIndex = context.watch<ChangeBodyOfHomeViewCubit>().index;
          final pages = context.watch<ChangeBodyOfHomeViewCubit>().pages;
          return Scaffold(
            body: SafeArea(child: pages[currentIndex]),

            bottomNavigationBar: currentIndex > 4
                ? null
                : BottomNavigationBar(
                    currentIndex: currentIndex,
                    onTap: (index) {
                      if (index == 2) {
                        context.read<SearchCubit>().products = context
                            .read<GetAllProductsCubit>()
                            .productsList;
                      }
                      context
                          .read<ChangeBodyOfHomeViewCubit>()
                          .changeBodyOfHomeView(index);
                    },
                    type: BottomNavigationBarType.shifting,
                    selectedItemColor: Colors.blue,
                    unselectedItemColor: Colors.grey,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_cart),
                        label: 'Cart',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search),
                        label: 'Search',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_basket),
                        label: 'Orders',
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

import 'package:fake_store/features/home/presentation/manager/cubits/filter_products_cubit.dart';
import 'package:fake_store/features/home/presentation/views/widgets/home_view_body_bloc_consumer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterProductsCubit(),
      child: HomeViewBodyBlocConsumer(),
    );
  }
}

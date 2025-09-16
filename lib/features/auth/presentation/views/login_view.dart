import 'package:fake_store/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:fake_store/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:fake_store/features/layout/presentation/manager/cubits/change_pages/change_body_of_home_view_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static const String routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(body: SafeArea(child: LoginViewBody())),
    );
  }
}

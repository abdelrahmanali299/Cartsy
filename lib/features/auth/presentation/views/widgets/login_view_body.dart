import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:fake_store/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:fake_store/features/auth/presentation/views/widgets/check_box_section.dart';
import 'package:fake_store/features/auth/presentation/views/widgets/divider_section.dart';
import 'package:fake_store/features/auth/presentation/views/widgets/dont_have_account_section.dart';
import 'package:fake_store/features/auth/presentation/views/widgets/login_fields_section.dart';
import 'package:fake_store/features/auth/presentation/views/widgets/login_view_bloc_consumer.dart';
import 'package:fake_store/features/auth/presentation/views/widgets/login_with_social_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = context.read<UserModel>();
    return SingleChildScrollView(
      child: Form(
        key: context.read<AuthCubit>().formKey,
        autovalidateMode: context.watch<AuthCubit>().autovalidateMode,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Cartsy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Login to your account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Welcome back we have missed you!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 60),
              LoginFieldsSection(user: user),
              SizedBox(height: 20),
              CheckBoxSection(),
              SizedBox(height: 20),

              LoginViewBlocConsumer(
                onPressed: () {
                  context.read<AuthCubit>().validate(
                    context: context,
                    onTap: () => context.read<AuthCubit>().login(
                      context: context,
                      userName: user.name!,
                      password: user.password!,
                    ),
                  );
                },
              ),
              SizedBox(height: 80),

              DividerSection(),
              SizedBox(height: 20),

              LoginWithSocialMedia(),
              SizedBox(height: 30),

              DontHaveAccountSection(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:fake_store/constant.dart';
import 'package:fake_store/core/functions/custom_snack_bar.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/core/widgets/custom_button.dart';
import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:fake_store/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:fake_store/features/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:fake_store/features/layout/presentation/views/layout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewBlocConsumer extends StatelessWidget {
  const LoginViewBlocConsumer({super.key, required this.onPressed});
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          current is LoginLoading ||
          current is LoginSuccess ||
          current is LoginFailure,
      listener: (context, state) {
        if (state is LoginSuccess) {
          SharedPreferencesSinglton.setBool(isLogedIn, true);
          print(context.read<UserModel>().name);
          Navigator.pushReplacementNamed(context, LayoutView.routeName);
          customSnackBar(context, 'Login Success', Colors.green);
        } else if (state is LoginFailure) {
          customSnackBar(context, state.errorMessage, Colors.red);
        }
      },
      builder: (context, state) {
        return CustomButton(
          title: state is LoginLoading ? CircularProgressIndicator() : 'Login',
          onPressed: onPressed,
        );
      },
    );
  }
}

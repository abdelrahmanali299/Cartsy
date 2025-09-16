import 'package:fake_store/core/functions/custom_snack_bar.dart';
import 'package:fake_store/core/widgets/custom_button.dart';
import 'package:fake_store/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:fake_store/features/auth/presentation/manager/auth_cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBlocConsumer extends StatelessWidget {
  const SignUpBlocConsumer({super.key, this.onPressed});
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          current is SignUpLoading ||
          current is SignUpSuccess ||
          current is SignUpFailure,
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pop(context);
          customSnackBar(context, 'Sign Up Success', Colors.green);
        } else if (state is SignUpFailure) {
          customSnackBar(context, state.errorMessage, Colors.red);
        }
      },
      builder: (context, state) {
        return CustomButton(
          title: state is SignUpLoading
              ? CircularProgressIndicator()
              : 'Sign Up',
          onPressed: onPressed,
        );
      },
    );
  }
}

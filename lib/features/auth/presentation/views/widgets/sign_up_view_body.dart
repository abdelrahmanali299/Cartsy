import 'package:fake_store/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:fake_store/features/auth/presentation/views/widgets/have_account_already.dart';
import 'package:fake_store/features/auth/presentation/views/widgets/sign_up_bloc_consumer.dart';
import 'package:fake_store/features/auth/presentation/views/widgets/sign_up_field_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20, width: double.infinity),
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
              'Create an account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Welcome let\'s fill your details!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 60),
            SignUpFieldSection(
              formKey: context.read<AuthCubit>().formKey,
              autovalidateMode: context.watch<AuthCubit>().autovalidateMode,
            ),
            SizedBox(height: 30),
            SignUpBlocConsumer(
              onPressed: () {
                context.read<AuthCubit>().validate(
                  context: context,
                  onTap: () => context.read<AuthCubit>().signUp(context),
                );
              },
            ),
            SizedBox(height: 40),

            HaveAccountAlready(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

import 'package:fake_store/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:fake_store/features/auth/presentation/views/widgets/sign_up_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static const String routeName = 'signUp';
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              padding: EdgeInsets.all(8),
              child: Icon(Icons.arrow_back_ios_new),
            ),
          ),
        ),
        body: SignUpViewBody(),
      ),
    );
  }
}

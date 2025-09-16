import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:fake_store/core/widgets/custom_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpFieldSection extends StatefulWidget {
  const SignUpFieldSection({
    super.key,
    required this.formKey,
    required this.autovalidateMode,
  });
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  @override
  State<SignUpFieldSection> createState() => _SignUpFieldSectionState();
}

class _SignUpFieldSectionState extends State<SignUpFieldSection> {
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    UserModel user = context.read<UserModel>();
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autovalidateMode,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'User Name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),
          CustomFormTextField(
            onSaved: (p0) {
              user.name = p0;
            },
            hintText: 'User Name',
            prefixIcon: Icon(Icons.person),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Email',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),
          CustomFormTextField(
            onSaved: (p0) {
              user.email = p0;
            },
            hintText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),
          CustomFormTextField(
            suffexIcon: IconButton(
              onPressed: () {
                setState(() {
                  isSecure = !isSecure;
                });
              },
              icon: isSecure
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.remove_red_eye),
            ),
            onSaved: (p0) {
              user.password = p0;
            },
            isSecure: isSecure,
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock),
          ),
        ],
      ),
    );
  }
}

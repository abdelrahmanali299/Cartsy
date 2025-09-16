import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:fake_store/core/widgets/custom_form_text_field.dart';
import 'package:flutter/material.dart';

class LoginFieldsSection extends StatefulWidget {
  const LoginFieldsSection({super.key, required this.user});
  final UserModel user;
  @override
  State<LoginFieldsSection> createState() => _LoginFieldsSectionState();
}

class _LoginFieldsSectionState extends State<LoginFieldsSection> {
  bool isSecure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            widget.user.name = p0;
          },
          hintText: 'User Name',
          prefixIcon: Icon(Icons.person),
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
            widget.user.password = p0;
          },
          isSecure: isSecure,
          hintText: 'Password',
          prefixIcon: Icon(Icons.lock),
        ),
      ],
    );
  }
}

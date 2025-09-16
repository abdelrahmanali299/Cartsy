import 'package:fake_store/features/auth/presentation/views/login_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HaveAccountAlready extends StatelessWidget {
  const HaveAccountAlready({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Have an account already? ',
            style: TextStyle(color: Colors.grey[800], fontSize: 16),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, LoginView.routeName);
              },

            text: 'Login',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}

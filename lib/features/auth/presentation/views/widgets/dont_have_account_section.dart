import 'package:fake_store/features/auth/presentation/views/sign_up_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DontHaveAccountSection extends StatelessWidget {
  const DontHaveAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Don\'t have an account? ',
            style: TextStyle(color: Colors.grey[800], fontSize: 16),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, SignUpView.routeName);
              },

            text: 'Sign Up',
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

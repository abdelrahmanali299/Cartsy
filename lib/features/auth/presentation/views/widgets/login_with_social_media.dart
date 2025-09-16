import 'package:fake_store/features/auth/presentation/views/widgets/social_media_container.dart';
import 'package:flutter/material.dart';

class LoginWithSocialMedia extends StatefulWidget {
  const LoginWithSocialMedia({super.key});

  @override
  State<LoginWithSocialMedia> createState() => _LoginWithSocialMediaState();
}

class _LoginWithSocialMediaState extends State<LoginWithSocialMedia> {
  List<dynamic> icon = [Icons.facebook, Icons.apple, Icons.g_mobiledata];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: List.generate(
        icon.length,
        (index) => SocialMediaContainer(icon: icon[index]),
      ),
    );
  }
}

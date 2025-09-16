import 'dart:convert';

import 'package:fake_store/constant.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/core/widgets/custom_button.dart';
import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:fake_store/features/auth/presentation/views/login_view.dart';
import 'package:fake_store/features/profile/presentation/views/widgets/profile_container_item.dart';
import 'package:flutter/material.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    UserModel user = UserModel.fromJson(
      jsonDecode(SharedPreferencesSinglton.getString(setUser)),
    );
    var width = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        const Center(
          child: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        SizedBox(height: 30),
        CircleAvatar(
          radius: width * 0.2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(width * 0.2),
            child: Image.asset('assets/images/avatar.jpg'),
          ),
        ),
        SizedBox(height: 20),

        ProfileContainerItem(iconData: Icons.person, title: user.name ?? ''),
        ProfileContainerItem(iconData: Icons.email, title: user.email ?? ''),
        ProfileContainerItem(iconData: Icons.phone, title: '+201012345678'),
        ProfileContainerItem(iconData: Icons.lock, title: user.password ?? ''),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: CustomButton(
            buttonColor: Colors.red,
            title: 'Logout',
            onPressed: () {
              SharedPreferencesSinglton.setBool(isLogedIn, false);
              Navigator.pushReplacementNamed(context, LoginView.routeName);
            },
          ),
        ),
      ],
    );
  }
}

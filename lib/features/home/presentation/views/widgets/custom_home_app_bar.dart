import 'dart:convert';

import 'package:fake_store/constant.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:fake_store/features/home/presentation/manager/cubits/notification_cubit.dart';
import 'package:fake_store/features/layout/presentation/manager/cubits/change_pages/change_body_of_home_view_cubit.dart';
import 'package:fake_store/features/home/presentation/notification_view.dart';
import 'package:fake_store/features/order/presentation/manager/cubits/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var user = UserModel.fromJson(
      jsonDecode(SharedPreferencesSinglton.getString(setUser)),
    );
    return ListTile(
      leading: FittedBox(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/avatar.jpg'),
            ),
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
        ),
      ),
      title: Text('Welcome', style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        user.name ?? '',
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
      trailing: Row(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, NotificationView.routeName);
              // context.read<ChangeBodyOfHomeViewCubit>().changeBodyOfHomeView(5);
            },
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                  ),
                  child: Icon(Icons.notifications_outlined),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<ChangeBodyOfHomeViewCubit>().changeBodyOfHomeView(1);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
    );
  }
}

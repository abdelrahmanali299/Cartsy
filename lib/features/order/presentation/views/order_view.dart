import 'dart:convert';

import 'package:fake_store/constant.dart';
import 'package:fake_store/core/functions/custom_app_bar.dart';
import 'package:fake_store/core/functions/custom_snack_bar.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/features/home/presentation/manager/cubits/notification_cubit.dart';
import 'package:fake_store/features/layout/presentation/manager/cubits/change_pages/change_body_of_home_view_cubit.dart';
import 'package:fake_store/features/order/presentation/manager/cubits/order_cubit.dart';
import 'package:fake_store/features/order/presentation/views/widgets/order_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  static const String routeName = '/order';
  @override
  Widget build(BuildContext context) {
    var userId = jsonDecode(SharedPreferencesSinglton.getString(setUser))['id'];
    return BlocListener<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state is GetSingleNotificationSuccess) {
          context.read<NotificationCubit>().deleteNotification(
            notificationId: state.notificationModel!.id.toString(),
            userId: userId,
          );
        } else if (state is GetSingleNotificationFailed) {
          customSnackBar(context, state.error, Colors.red);
        }
      },
      child: Column(
        children: [
          customAppBar(context, title: 'Orders'),
          Expanded(
            child: BlocListener<OrderCubit, OrderState>(
              listener: (context, state) {
                if (state is DeleteOrderSuccess) {
                  customSnackBar(context, 'Deleted', Colors.green);
                } else if (state is DeleteOrderFailed) {
                  customSnackBar(context, state.error, Colors.red);
                }
              },
              child: OrderViewBody(),
            ),
          ),
        ],
      ),
    );
  }
}

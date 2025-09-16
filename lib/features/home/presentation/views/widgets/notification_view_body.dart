import 'dart:convert';

import 'package:fake_store/constant.dart';
import 'package:fake_store/core/functions/custom_snack_bar.dart';
import 'package:fake_store/core/functions/get_dummy_notifications.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/features/home/presentation/manager/cubits/notification_cubit.dart';
import 'package:fake_store/features/home/presentation/views/widgets/notification_item.dart';
import 'package:fake_store/features/layout/presentation/manager/cubits/change_pages/change_body_of_home_view_cubit.dart';
import 'package:fake_store/features/order/presentation/manager/cubits/order_cubit.dart';
import 'package:fake_store/features/order/presentation/views/widgets/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationViewBody extends StatefulWidget {
  const NotificationViewBody({super.key});

  @override
  State<NotificationViewBody> createState() => _NotificationViewBodyState();
}

class _NotificationViewBodyState extends State<NotificationViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      buildWhen: (previous, current) =>
          current is GetAllNotificationsSuccess ||
          current is GetAllNotificationsFailed ||
          current is GetAllNotificationsLoading,

      builder: (context, state) {
        if (state is GetAllNotificationsSuccess) {
          return BlocListener<OrderCubit, OrderState>(
            listener: (outerContext, state) {
              if (state is GetSingleOrderSuccess) {
                Navigator.push(
                  outerContext,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: outerContext.read<OrderCubit>(),
                      child: OrderDetails(orderModel: state.orderModel),
                    ),
                  ),
                );
              } else if (state is GetSingleOrderFailed) {
                customSnackBar(context, state.error, Colors.red);
              }
            },
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(state.notifications[index].id.toString()),
                  onDismissed: (direction) {
                    context.read<NotificationCubit>().deleteNotification(
                      notificationId: state.notifications[index].id.toString(),
                      userId: jsonDecode(
                        SharedPreferencesSinglton.getString(setUser),
                      )['id'],
                    );
                  },
                  child: NotificationItem(
                    notificationModel: state.notifications[index],
                    onTap: () {
                      print('pressssss');
                      String userId = jsonDecode(
                        SharedPreferencesSinglton.getString(setUser),
                      )['id'];

                      context.read<OrderCubit>().getSingleOrder(
                        orderId: state.notifications[index].orderId,
                        userId: userId,
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: state.notifications.length,
            ),
          );
        } else if (state is GetAllNotificationsFailed) {
          return Center(child: Text(state.error));
        } else {
          return Skeletonizer(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return NotificationItem(
                  notificationModel: getDummyNotifications()[index],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: getDummyNotifications().length,
            ),
          );
        }
      },
    );
  }
}

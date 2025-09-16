import 'dart:developer';

import 'package:fake_store/core/functions/custom_app_bar.dart';
import 'package:fake_store/core/functions/custom_snack_bar.dart';
import 'package:fake_store/features/home/presentation/manager/cubits/notification_cubit.dart';
import 'package:fake_store/features/home/presentation/views/widgets/notification_view_body.dart';
import 'package:fake_store/features/order/presentation/manager/cubits/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});
  static const String routeName = '/notification';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: NotificationCubit()),
        BlocProvider.value(value: OrderCubit()),
      ],
      child: Scaffold(
        appBar: customAppBar(context, title: 'Notifications', isLeading: true),
        body: BlocListener<NotificationCubit, NotificationState>(
          listenWhen: (previous, current) =>
              current is DeleteNotificationSuccess ||
              current is DeleteNotificationFailed,

          listener: (context, state) {
            print(">>> BlocListener got state: //");
            if (state is DeleteNotificationSuccess) {
              customSnackBar(context, 'Deleted', Colors.green);
            } else if (state is DeleteNotificationFailed) {
              customSnackBar(context, state.error, Colors.red);
            }
          },
          child: NotificationViewBody(),
        ),
      ),
    );
  }
}

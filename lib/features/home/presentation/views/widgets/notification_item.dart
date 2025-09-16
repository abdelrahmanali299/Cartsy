import 'package:fake_store/features/order/data/models/notification_model.dart';
import 'package:fake_store/features/order/presentation/manager/cubits/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notificationModel,
    this.onTap,
  });
  final NotificationModel notificationModel;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: ListTile(
          trailing: BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              if (state is GetSingleOrderLoading) {
                return CircularProgressIndicator(color: Colors.blue);
              } else {
                return SizedBox();
              }
            },
          ),

          title: Text(
            notificationModel.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
              Flexible(
                child: Text(
                  notificationModel.body,
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ),
              Flexible(
                child: Text(
                  style: TextStyle(color: Colors.grey[500]),
                  '(${notificationModel.date.day}-${notificationModel.date.month}-${notificationModel.date.year}) ${notificationModel.date.hour}:${notificationModel.date.minute}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

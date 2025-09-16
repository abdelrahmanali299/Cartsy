import 'dart:convert';

import 'package:fake_store/constant.dart';
import 'package:fake_store/core/functions/get_dummy_orders.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/features/home/presentation/manager/cubits/notification_cubit.dart';
import 'package:fake_store/features/order/data/models/order_model.dart';
import 'package:fake_store/features/order/presentation/manager/cubits/order_cubit.dart';
import 'package:fake_store/features/order/presentation/views/widgets/order_card.dart';
import 'package:fake_store/features/order/presentation/views/widgets/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderViewBody extends StatefulWidget {
  const OrderViewBody({super.key});
  @override
  State<OrderViewBody> createState() => _OrderViewBodyState();
}

class _OrderViewBodyState extends State<OrderViewBody> {
  @override
  initState() {
    super.initState();
    context.read<OrderCubit>().getAllOrders(context);
  }

  List<OrderModel> orders = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      buildWhen: (previous, current) =>
          current is GetAllOrdersSuccess ||
          current is GetAllOrdersFailed ||
          current is GetAllOrdersLoading,

      // current is DeleteOrderSuccess ||
      // current is DeleteOrderFailed,
      builder: (context, state) {
        if (state is GetAllOrdersSuccess) {
          orders = state.orders;
          return ListView.separated(
            itemBuilder: (outerContext, index) {
              return GestureDetector(
                onTap: () {
                  print(
                    'order cubit is ${outerContext.read<OrderCubit>().hashCode}',
                  );
                  Navigator.push(
                    outerContext,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: outerContext.read<OrderCubit>(),
                        child: OrderDetails(orderModel: state.orders[index]),
                      ),
                    ),
                  );
                },
                child: Dismissible(
                  onDismissed: (direction) {
                    var userId = jsonDecode(
                      SharedPreferencesSinglton.getString(setUser),
                    )['id'];
                    context.read<OrderCubit>().deleteOrder(
                      orderId: state.orders[index].orderId,
                      userId: userId,
                    );
                    orders.removeAt(index);
                    context.read<NotificationCubit>().getSingleNotification(
                      orderId: state.orders[index].orderId.toString(),
                      userId: userId,
                    );
                  },
                  key: Key(state.orders[index].orderId.toString()),
                  child: OrderCard(order: state.orders[index]),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemCount: state.orders.length,
          );
        } else if (state is GetAllOrdersFailed) {
          return Center(child: Text(state.message));
        } else {
          return Skeletonizer(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return OrderCard(order: getDummyOrders()[index]);
              },
              separatorBuilder: (context, index) => SizedBox(height: 20),
              itemCount: getDummyOrders().length,
            ),
          );
        }
      },
    );
  }
}

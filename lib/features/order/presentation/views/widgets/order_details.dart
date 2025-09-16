import 'package:fake_store/core/functions/custom_snack_bar.dart';
import 'package:fake_store/features/order/data/models/order_model.dart';
import 'package:fake_store/features/order/presentation/manager/cubits/order_cubit.dart';
import 'package:fake_store/features/order/presentation/views/widgets/order_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[300],
            ),
            child: Icon(Icons.arrow_back_ios_new),
          ),
        ),
      ),
      body: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          if (state is UpdateOrderSuccess) {
            customSnackBar(context, 'Order Updated Successfully', Colors.green);
          } else if (state is UpdateOrderFailed) {
            customSnackBar(context, state.error, Colors.red);
          }
        },
        buildWhen: (previous, current) => current is UpdateOrderSuccess,
        builder: (context, state) {
          if (state is UpdateOrderSuccess) {
            return OrderDetailsBody(orderModel: orderModel);
          }
          return OrderDetailsBody(orderModel: orderModel);
        },
      ),
    );
  }
}

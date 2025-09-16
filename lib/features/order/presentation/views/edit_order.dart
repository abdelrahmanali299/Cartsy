import 'dart:convert';

import 'package:csc_picker/csc_picker.dart';
import 'package:fake_store/constant.dart';
import 'package:fake_store/core/functions/custom_app_bar.dart';
import 'package:fake_store/core/functions/custom_snack_bar.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/core/widgets/custom_button.dart';
import 'package:fake_store/features/cart/presentation/manager/cubits/cart/cart_cubit.dart';
import 'package:fake_store/features/cart/presentation/views/widgets/add_address.dart';
import 'package:fake_store/features/layout/presentation/views/layout_view.dart';
import 'package:fake_store/features/order/data/models/order_model.dart';
import 'package:fake_store/features/order/presentation/manager/cubits/order_cubit.dart';
import 'package:fake_store/features/order/presentation/views/widgets/order_details.dart';
import 'package:fake_store/features/order/presentation/views/widgets/order_item_for_editing.dart';
import 'package:fake_store/features/order/presentation/views/widgets/update_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditOrder extends StatelessWidget {
  const EditOrder(this.order, {super.key});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'Edit Order', isLeading: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            UpdateAddress(order: order),
            SizedBox(height: 20),
            Expanded(
              child: BlocConsumer<OrderCubit, OrderState>(
                listener: (context, state) {
                  if (state is DeleteProductFromOrderEditSuccess) {
                    order.products = state.newProducts;
                  }
                  // TODO: implement listener
                },
                buildWhen: (previous, current) =>
                    current is DeleteProductFromOrderEditSuccess,
                builder: (context, state) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return OrderItemForEditing(order: order, index: index);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20);
                    },
                    itemCount: order.products.length,
                  );
                },
              ),
            ),

            BlocBuilder<OrderCubit, OrderState>(
              buildWhen: (previous, current) =>
                  current is UpdateAddressSuccess ||
                  current is UpdateOrderFailed ||
                  current is UpadateOrderLoading,

              builder: (context, state) {
                return CustomButton(
                  title: state is UpdateCartLoading
                      ? CircularProgressIndicator()
                      : 'Save',
                  onPressed: () {
                    var userId = jsonDecode(
                      SharedPreferencesSinglton.getString(setUser),
                    )['id'];
                    if (order.products.isEmpty) {
                      context.read<OrderCubit>().deleteOrder(
                        orderId: order.orderId,
                        userId: userId,
                      );
                    } else {
                      context.read<OrderCubit>().updateOrder(
                        order: order,
                        userId: userId,
                      );
                      Navigator.pop(context);
                    }
                  },
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

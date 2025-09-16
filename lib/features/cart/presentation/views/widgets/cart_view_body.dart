import 'dart:convert';

import 'package:fake_store/constant.dart';
import 'package:fake_store/core/functions/custom_bottom_modal_sheet.dart';
import 'package:fake_store/core/services/local_notification_service.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/core/widgets/custom_button.dart';
import 'package:fake_store/core/widgets/custom_form_text_field.dart';
import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:fake_store/features/cart/data/models/cart_item_model.dart';
import 'package:fake_store/features/cart/presentation/manager/cubits/cart/cart_cubit.dart';
import 'package:fake_store/features/cart/presentation/views/widgets/add_address.dart';
import 'package:fake_store/features/cart/presentation/views/widgets/cart_item.dart';
import 'package:fake_store/features/cart/presentation/views/widgets/customm_cart_app_bar.dart';
import 'package:fake_store/features/cart/presentation/views/widgets/discount_text_field.dart';
import 'package:fake_store/features/cart/presentation/views/widgets/total_price.dart';
import 'package:fake_store/features/home/presentation/manager/cubits/notification_cubit.dart';
import 'package:fake_store/features/layout/presentation/manager/cubits/change_pages/change_body_of_home_view_cubit.dart';
import 'package:fake_store/features/order/data/models/notification_model.dart';
import 'package:fake_store/features/order/data/models/order_model.dart';
import 'package:fake_store/features/order/presentation/manager/cubits/order_cubit.dart';
import 'package:fake_store/features/order/presentation/views/widgets/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key, this.cartItems});
  final List<Map<String, dynamic>>? cartItems;
  @override
  Widget build(BuildContext outerContext) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView(
        children: [
          CustommCartAppBar(),
          SizedBox(height: 30),
          for (var cartItem in cartItems ?? [])
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: CartItem(cartItemModel: CartItemModel.fromSql(cartItem)),
            ),
          SizedBox(height: 30),
          DiscountTextField(),
          SizedBox(height: 30),

          TotalPrice(),
          SizedBox(height: 30),

          BlocBuilder<OrderCubit, OrderState>(
            builder: (context, state) {
              return CustomButton(
                title: state is OrderAddedLoading
                    ? CircularProgressIndicator()
                    : 'Place Order',

                onPressed: () async {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(
                            context,
                          ).viewInsets.bottom, // علشان الكيبورد
                        ),
                        child: AddAddress(
                          onAddressSelected: (address) {
                            Navigator.pop(context); // يقفل البوتوم شيت

                            // هنا بقى ممكن تبعت الأوردر بالـ address

                            add_order(outerContext, address: address);
                          },
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void add_order(BuildContext context, {required AddressModel address}) {
    var cartItems = context.read<CartCubit>().cartItems;
    var userId = jsonDecode(SharedPreferencesSinglton.getString(setUser))['id'];
    OrderModel order = OrderModel(
      orderDate: DateTime.now(),
      orderId: Uuid().v4(),
      products: cartItems!.map((e) => CartItemModel.fromSql(e)).toList(),
      address: address,
    );
    NotificationModel notificationModel = NotificationModel(
      NotificationModel.generateNotificationId(),
      orderId: order.orderId,
      title: 'Order Placed Successfully',
      body: 'Your order has been placed successfully',
      date: DateTime.now(),
    );
    context.read<OrderCubit>().addOrder(order, userId);
    context.read<CartCubit>().clearCart();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderDetails(orderModel: order)),
    );
    var notificationCubit = context.read<NotificationCubit>();
    Future.delayed(const Duration(seconds: 5), () {
      // 1- عرض الإشعار
      LocalNotificationService.showBasicNotification(
        notificationModel: notificationModel,
      );

      // 2- إضافة الإشعار للـ Cubit
      notificationCubit.addNotification(
        notificationModel: notificationModel,
        userId: userId,
      );
    });
  }
}

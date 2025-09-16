import 'package:fake_store/features/cart/presentation/views/widgets/cart_view_body_bloc_consumer.dart';
import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  static const String routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    return CartViewBodyBlocConsumer();
  }
}

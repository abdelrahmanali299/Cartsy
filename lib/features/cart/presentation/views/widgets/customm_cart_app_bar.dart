import 'package:fake_store/features/cart/presentation/manager/cubits/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustommCartAppBar extends StatelessWidget {
  const CustommCartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            'My Cart',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Spacer(),

          GestureDetector(
            onTap: () {
              var cartItems = context.read<CartCubit>().cartItems;
              cartItems!.isEmpty ? null : context.read<CartCubit>().clearCart();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: Icon((Icons.remove_shopping_cart)),
            ),
          ),
        ],
      ),
    );
  }
}

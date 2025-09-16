import 'package:fake_store/core/functions/custom_snack_bar.dart';
import 'package:fake_store/features/cart/presentation/manager/cubits/cart/cart_cubit.dart';
import 'package:fake_store/features/cart/presentation/views/widgets/cart_empty.dart';
import 'package:fake_store/features/cart/presentation/views/widgets/cart_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartViewBodyBlocConsumer extends StatefulWidget {
  const CartViewBodyBlocConsumer({super.key});

  @override
  State<CartViewBodyBlocConsumer> createState() =>
      _CartViewBodyBlocConsumerState();
}

class _CartViewBodyBlocConsumerState extends State<CartViewBodyBlocConsumer> {
  List<Map<String, dynamic>>? cartItems = [];

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().readDataFromCart();
    cartItems = context.read<CartCubit>().cartItems;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is DeleteCartSuccess) {
          customSnackBar(context, 'Deleted', Colors.green);
        } else if (state is DeleteCartError) {
          customSnackBar(context, state.message, Colors.red);
        }
      },
      builder: (context, state) {
        if (state is AddCartLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.blue));
        } else if (state is AddCartError) {
          {
            return Center(
              child: Text(state.message, style: TextStyle(color: Colors.red)),
            );
          }
        } else if (state is DeleteCartSuccess) {
          cartItems = context.read<CartCubit>().cartItems;
          return cartItems!.isNotEmpty
              ? CartViewBody(cartItems: cartItems)
              : CartEmpty();
        }

        return cartItems!.isNotEmpty
            ? CartViewBody(cartItems: cartItems)
            : CartEmpty();
      },
    );
  }
}

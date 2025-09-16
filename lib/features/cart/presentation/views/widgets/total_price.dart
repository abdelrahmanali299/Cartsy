import 'package:fake_store/features/cart/presentation/manager/cubits/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Subtotal",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "\$${calculateTotalPrice(context)}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(color: Colors.grey[300]),
          Row(
            children: [
              Text(
                "Total",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "\$${calculateTotalPrice(context)}",

                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  calculateTotalPrice(BuildContext context) {
    var cartItems = context.watch<CartCubit>().cartItems;
    double totalPrice = 0;
    for (var element in cartItems ?? []) {
      totalPrice += element['Pprice'] * element['Pquantity'];
    }

    return totalPrice.toStringAsFixed(2);
  }
}

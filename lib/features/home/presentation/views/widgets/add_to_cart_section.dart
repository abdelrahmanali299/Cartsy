import 'package:fake_store/core/functions/custom_snack_bar.dart';
import 'package:fake_store/features/cart/data/models/cart_item_model.dart';
import 'package:fake_store/features/cart/presentation/manager/cubits/cart/cart_cubit.dart';
import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:fake_store/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AddToCartSection extends StatefulWidget {
  const AddToCartSection({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  State<AddToCartSection> createState() => _AddToCartSectionState();
}

class _AddToCartSectionState extends State<AddToCartSection> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is AddCartSuccess && HomeViewBody.isAdded) {
          customSnackBar(context, 'Added to cart', Colors.green);
          HomeViewBody.isAdded = false;
        } else if (state is AddCartError) {
          customSnackBar(context, state.message, Colors.red);
        } else if (state is UpdateCartSuccess) {
          customSnackBar(context, 'Updated', Colors.green);
        } else if (state is UpdateCartError) {
          customSnackBar(context, state.message, Colors.red);
        }
      },
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          spacing: 10,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (count > 1) count--;
                });
              },
              icon: Icon(Icons.remove),
            ),
            Text(count.toString(), style: TextStyle(fontSize: 20)),
            IconButton(
              onPressed: () {
                setState(() {
                  count++;
                });
              },
              icon: Icon(Icons.add),
            ),

            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
              ),
              onPressed: () {
                addProductToCartHandle(context);
                context.read<CartCubit>().readDataFromCart();
                HomeViewBody.isAdded = false;
              },
              child: Text('Add to cart'),
            ),
          ],
        ),
      ),
    );
  }

  void addProductToCartHandle(BuildContext context) {
    context.read<CartCubit>().readDataFromCart();
    for (var element in context.read<CartCubit>().cartItems ?? []) {
      if (element['product_id'] == widget.productModel.id) {
        context.read<CartCubit>().updateProductQuantity(
          cartItem: CartItemModel(
            productModel: widget.productModel,
            quantity: element['Pquantity'] + count,
          ),
        );

        return;
      }
    }
    context.read<CartCubit>().addToCart(
      cartItem: CartItemModel(
        productModel: widget.productModel,
        quantity: count,
      ),
    );
  }
}

import 'package:fake_store/features/cart/data/models/cart_item_model.dart';
import 'package:fake_store/features/cart/presentation/manager/cubits/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.cartItemModel});
  final CartItemModel cartItemModel;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  num? quantity;
  @override
  void initState() {
    super.initState();
    quantity = widget.cartItemModel.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: AspectRatio(
                aspectRatio: 1.5,
                child: FittedBox(
                  child: Image.network(widget.cartItemModel.productModel.image),
                ),
              ),
            ),
            Flexible(
              child: Column(
                spacing: 5,
                children: [
                  Text(widget.cartItemModel.productModel.title),
                  Text(
                    '\$${calculateProductPrice(context)}',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        if (quantity! > 1) {
                          quantity = quantity! - 1;
                          setState(() {
                            widget.cartItemModel.quantity = quantity;
                          });

                          context.read<CartCubit>().updateProductQuantity(
                            cartItem: CartItemModel(
                              productModel: widget.cartItemModel.productModel,
                              quantity: widget.cartItemModel.quantity,
                            ),
                          );
                        }
                      },
                      child: Icon(Icons.remove),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '$quantity',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueGrey[200],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        quantity = quantity! + 1;

                        setState(() {
                          widget.cartItemModel.quantity = quantity;
                        });
                        context.read<CartCubit>().updateProductQuantity(
                          cartItem: CartItemModel(
                            productModel: widget.cartItemModel.productModel,
                            quantity: widget.cartItemModel.quantity,
                          ),
                        );
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<CartCubit>().deleteFromCart(
                  productId: widget.cartItemModel.productModel.id,
                );
              },
              icon: Icon(Icons.delete_forever),
            ),
          ],
        ),
      ),
    );
  }

  calculateProductPrice(BuildContext context) {
    var totalPrice = quantity! * widget.cartItemModel.productModel.price;
    return totalPrice.toStringAsFixed(2);
  }
}

import 'dart:convert';

import 'package:fake_store/constant.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/features/order/data/models/order_model.dart';
import 'package:fake_store/features/order/presentation/manager/cubits/order_cubit.dart';
import 'package:fake_store/features/order/presentation/views/edit_order.dart';
import 'package:fake_store/features/order/presentation/views/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderItemForEditing extends StatefulWidget {
  const OrderItemForEditing({
    super.key,
    required this.index,
    required this.order,
  });
  final OrderModel order;
  final int index;

  @override
  State<OrderItemForEditing> createState() => _OrderItemForEditingState();
}

class _OrderItemForEditingState extends State<OrderItemForEditing> {
  OrderModel? orderModel;
  @override
  void initState() {
    super.initState();
    orderModel = widget.order;
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
                  child: Image.network(
                    orderModel!.products[widget.index].productModel.image,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Column(
                spacing: 5,
                children: [
                  Text(
                    orderModel?.products[widget.index].productModel.title ?? '',
                  ),
                  Text(
                    '${orderModel?.products[widget.index].productModel.price}',
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
                        var quantity =
                            orderModel?.products[widget.index].quantity;
                        if (quantity == 1) return;
                        setState(() {
                          orderModel?.products[widget.index].quantity =
                              quantity! - 1;
                        });
                      },
                      child: Icon(Icons.remove),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      ' ${orderModel?.products[widget.index].quantity}',
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
                        var quantity =
                            orderModel?.products[widget.index].quantity;
                        setState(() {
                          orderModel?.products[widget.index].quantity =
                              quantity! + 1;
                        });
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                orderModel?.products.removeAt(widget.index);
                context.read<OrderCubit>().deleteProductFromOrderEdit(
                  newProducts: orderModel?.products ?? [],
                );
              },
              icon: Icon(Icons.delete_forever),
            ),
          ],
        ),
      ),
    );
  }
}

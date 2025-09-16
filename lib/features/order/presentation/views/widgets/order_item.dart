import 'package:fake_store/features/order/data/models/order_model.dart';
import 'package:fake_store/features/order/presentation/views/edit_order.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.index, required this.order});
  final int index;
  final OrderModel order;
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
                    order.products[index].productModel.image,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Column(
                spacing: 5,
                children: [
                  Text(order.products[index].productModel.title),
                  Row(
                    children: [
                      Text(
                        '${calculateProductPrice(context)}',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text('Quantity: ${order.products[index].quantity}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculateProductPrice(BuildContext context) {
    var productPrice = order.products[index].productModel.price;

    return productPrice.toStringAsFixed(2);
  }
}

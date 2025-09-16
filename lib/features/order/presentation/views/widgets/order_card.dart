import 'package:fake_store/features/order/data/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      elevation: 5,
      child: ListTile(
        title: Text('Order ID: ${order.orderId} '),
        subtitle: Text(
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          'Order Date: ${order.orderDate.day}-${order.orderDate.month}-${order.orderDate.year} ',
        ),
        trailing: Text('Total Amount: ${calcTotalAmount()}'),
      ),
    );
  }

  calcTotalAmount() {
    num totalAmount = 0;
    for (var element in order.products) {
      totalAmount += element.productModel.price * element.quantity!;
    }
    return totalAmount.toStringAsFixed(2);
  }
}

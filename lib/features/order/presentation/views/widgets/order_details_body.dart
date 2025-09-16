import 'package:fake_store/features/order/data/models/order_model.dart';
import 'package:fake_store/features/order/presentation/manager/cubits/order_cubit.dart';
import 'package:fake_store/features/order/presentation/views/edit_order.dart';
import 'package:fake_store/features/order/presentation/views/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({super.key, required this.orderModel});
  final OrderModel orderModel;
  @override
  Widget build(BuildContext outerContext) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Navigator.push(
                outerContext,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: outerContext.read<OrderCubit>(),
                    child: EditOrder(orderModel),
                  ),
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'Order Id: ${orderModel.orderId}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Text(
                  'Order Date: ${orderModel.orderDate.day}-${orderModel.orderDate.month}-${orderModel.orderDate.year}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Divider(color: Colors.grey[400]),
                Center(
                  child: Text(
                    'Address Info: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Text(
                  'Country: ${orderModel.address?.country}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Colors.blue,
                  ),
                ),
                Text(
                  'State: ${orderModel.address?.state}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Colors.blue,
                  ),
                ),
                Text(
                  'City: ${orderModel.address?.city}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Colors.blue,
                  ),
                ),
                Text(
                  'Street: ${orderModel.address?.street}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: orderModel.products.length,
            itemBuilder: (context, index) {
              return OrderItem(order: orderModel, index: index);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Total Price: \$${calcTotalPrice()}',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  calcTotalPrice() {
    num totalPrice = 0;
    for (var item in orderModel.products) {
      totalPrice += item.quantity ?? 1 * item.productModel.price;
    }
    return totalPrice.toStringAsFixed(2);
  }
}

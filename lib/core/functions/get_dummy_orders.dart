import 'package:fake_store/core/functions/get_dummy_products.dart';
import 'package:fake_store/features/cart/data/models/cart_item_model.dart';
import 'package:fake_store/features/order/data/models/order_model.dart';

List<OrderModel> getDummyOrders() {
  return List.generate(5, (e) {
    return OrderModel(
      orderDate: DateTime.now(),
      products: List.generate(
        5,
        (e) => CartItemModel(productModel: getDummyProducts()[e], quantity: 1),
      ),
      orderId: 'dsfdsfsssssssssssssssssssssssssssss',
    );
  });
}

import 'package:dartz/dartz.dart';
import 'package:fake_store/features/order/data/models/order_model.dart';

abstract class OrderRepo {
  Future<Either<String, void>> addOrder(OrderModel orderModel, String userId);
  Future<Either<String, List<Map<String, dynamic>>>> getAllOrders(
    String userId,
  );
  Future<Either<String, OrderModel>> getSingleOrder({
    required String orderId,
    required String userId,
  });

  Future<Either<String, void>> deleteOrder({
    required String orderId,
    required String userId,
  });
  Future<Either<String, void>> updateOrder({
    required orderId,
    required userId,
    required OrderModel order,
  });
}

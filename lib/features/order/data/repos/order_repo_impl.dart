import 'package:dartz/dartz.dart';
import 'package:fake_store/constant.dart';
import 'package:fake_store/core/services/fire_store_service.dart';
import 'package:fake_store/features/order/data/models/order_model.dart';
import 'package:fake_store/features/order/data/repos/order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  final fireStoreService = FireStoreService();
  @override
  Future<Either<String, void>> addOrder(
    OrderModel orderModel,
    String userId,
  ) async {
    try {
      await fireStoreService.addDataToSubCollection(
        mainPath: users,
        subPath: orders,
        data: orderModel.toJson(),
        mainId: userId,
        subId: orderModel.orderId,
      );
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<Map<String, dynamic>>>> getAllOrders(
    String userId,
  ) async {
    try {
      return right(
        await fireStoreService.getDataFromSubCollection(
          query: {'orderBy': 'orderDate', 'descending': true},
          mainPath: users,
          subPath: orders,
          mainId: userId,
        ),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, OrderModel>> getSingleOrder({
    required String orderId,
    required String userId,
  }) async {
    try {
      var res = await fireStoreService.getDataFromSubCollection(
        mainPath: users,
        subPath: orders,
        mainId: userId,
        query: {'where': 'orderId', 'value': orderId},
      );
      print('ressssssssssssssssssssssssss ${res.length}');
      return right(OrderModel.fromJson(res[0]));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteOrder({
    required String orderId,
    required String userId,
  }) async {
    try {
      await fireStoreService.deleteDataFromSubCollection(
        mainPath: users,
        subPath: orders,
        mainId: userId,
        subId: orderId,
      );
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> updateOrder({
    required orderId,
    required userId,
    required OrderModel order,
  }) async {
    try {
      await fireStoreService.updateFromSubCollection(
        mainPath: users,
        subPath: orders,
        mainId: userId,
        subId: orderId,
        data: order.toJson(),
      );
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}

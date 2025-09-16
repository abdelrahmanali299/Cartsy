import 'package:dartz/dartz.dart';
import 'package:fake_store/constant.dart';
import 'package:fake_store/core/services/fire_store_service.dart';
import 'package:fake_store/features/home/data/repos/notification_repo.dart';
import 'package:fake_store/features/order/data/models/notification_model.dart';
import 'package:fake_store/features/order/data/models/order_model.dart';

class NotifcationRepoImpl implements NotificationRepo {
  FireStoreService fireStoreService = FireStoreService();
  @override
  Future<Either<String, void>> addNotification({
    required NotificationModel notificationModel,
    required String userId,
  }) async {
    try {
      await fireStoreService.addDataToSubCollection(
        mainPath: users,
        subPath: notifications,
        data: notificationModel.toJson(),
        mainId: userId,
        subId: notificationModel.id.toString(),
      );
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<Map<String, dynamic>>>> getAllNotifications(
    String userId,
  ) async {
    try {
      return right(
        await fireStoreService.getDataFromSubCollection(
          query: {'orderBy': 'date', 'descending': true},
          mainPath: users,
          subPath: notifications,
          mainId: userId,
        ),
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteNotification({
    required String notificationId,
    required String userId,
  }) async {
    try {
      await fireStoreService.deleteDataFromSubCollection(
        mainPath: users,
        subPath: notifications,
        mainId: userId,
        subId: notificationId,
      );
      return Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, NotificationModel?>> getSingleNotification({
    required String orderId,
    required userId,
  }) async {
    try {
      var res = await fireStoreService.getDataFromSubCollection(
        mainPath: users,
        subPath: notifications,

        query: {'where': 'orderId', 'value': orderId},
        mainId: userId,
      );
      return right(res.isEmpty ? null : NotificationModel.fromJson(res[0]));
    } catch (e) {
      return Left(e.toString());
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:fake_store/features/order/data/models/notification_model.dart';
import 'package:fake_store/features/order/data/models/order_model.dart';

abstract class NotificationRepo {
  Future<Either<String, void>> addNotification({
    required NotificationModel notificationModel,
    required String userId,
  });
  Future<Either<String, List<Map<String, dynamic>>>> getAllNotifications(
    String userId,
  );
  Future<Either<String, void>> deleteNotification({
    required String notificationId,
    required String userId,
  });
  Future<Either<String, NotificationModel?>> getSingleNotification({
    required String orderId,
    required userId,
  });
}

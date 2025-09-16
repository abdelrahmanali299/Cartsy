import 'package:fake_store/features/order/data/models/notification_model.dart';

List<NotificationModel> getDummyNotifications() {
  return List.generate(
    5,
    (e) => NotificationModel(
      e,
      orderId: 'dsfsdfsdf',
      title: 'Order Placed Successfully',
      body: 'Your order has been placed successfully',
      date: DateTime.now(),
    ),
  );
}

part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationAddedSuccess extends NotificationState {}

class NotificationAddedFailed extends NotificationState {
  final String error;
  NotificationAddedFailed(this.error);
}

class GetAllNotificationsLoading extends NotificationState {}

class GetAllNotificationsSuccess extends NotificationState {
  final List<NotificationModel> notifications;
  GetAllNotificationsSuccess(this.notifications);
}

class GetAllNotificationsFailed extends NotificationState {
  final String error;
  GetAllNotificationsFailed(this.error);
}

class DeleteNotificationSuccess extends NotificationState {}

class DeleteNotificationFailed extends NotificationState {
  final String error;
  DeleteNotificationFailed(this.error);
}

class GetSingleNotificationSuccess extends NotificationState {
  final NotificationModel? notificationModel;
  GetSingleNotificationSuccess(this.notificationModel);
}

class GetSingleNotificationFailed extends NotificationState {
  final String error;
  GetSingleNotificationFailed(this.error);
}

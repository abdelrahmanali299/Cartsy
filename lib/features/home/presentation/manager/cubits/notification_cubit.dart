import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fake_store/constant.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/features/home/data/repos/notifcation_repo_impl.dart';
import 'package:fake_store/features/order/data/models/notification_model.dart';
import 'package:fake_store/features/order/data/models/order_model.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  @override
  void onChange(Change<NotificationState> change) {
    super.onChange(change);
    log(change.toString());
  }

  NotificationCubit() : super(NotificationInitial());

  addNotification({
    required NotificationModel notificationModel,
    required String userId,
  }) async {
    var res = await NotifcationRepoImpl().addNotification(
      notificationModel: notificationModel,
      userId: userId,
    );
    res.fold(
      (failure) => emit(NotificationAddedFailed(failure)),
      (r) => emit(NotificationAddedSuccess()),
    );
  }

  getAllNotifications() async {
    emit(GetAllNotificationsLoading());
    var res = await NotifcationRepoImpl().getAllNotifications(
      jsonDecode(SharedPreferencesSinglton.getString(setUser))['id'],
    );
    res.fold((failure) => emit(GetAllNotificationsFailed(failure)), (r) {
      log(r.toString());
      emit(
        GetAllNotificationsSuccess(
          r.map((e) => NotificationModel.fromJson(e)).toList(),
        ),
      );
    });
  }

  deleteNotification({
    required String notificationId,
    required String userId,
  }) async {
    var res = await NotifcationRepoImpl().deleteNotification(
      notificationId: notificationId,
      userId: userId,
    );
    res.fold((failure) => emit(DeleteNotificationFailed(failure)), (r) {
      emit(DeleteNotificationSuccess());
    });
  }

  getSingleNotification({required String orderId, required userId}) async {
    var res = await NotifcationRepoImpl().getSingleNotification(
      orderId: orderId,
      userId: userId,
    );
    res.fold(
      (failure) => emit(GetSingleNotificationFailed(failure)),
      (r) => emit(GetSingleNotificationSuccess(r)),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:fake_store/features/cart/presentation/views/cart_view.dart';
import 'package:fake_store/features/home/presentation/notification_view.dart';
import 'package:fake_store/features/home/presentation/views/home_view.dart';
import 'package:fake_store/features/order/presentation/views/order_view.dart';
import 'package:fake_store/features/profile/presentation/views/profile_view.dart';
import 'package:fake_store/features/search/presentation/views/search_view.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'change_body_of_home_view_state.dart';

class ChangeBodyOfHomeViewCubit extends Cubit<ChangeBodyOfHomeViewState> {
  ChangeBodyOfHomeViewCubit() : super(ChangeBodyOfHomeViewInitial());

  int index = 0;
  final pages = [
    HomeView(),
    CartView(),
    SearchView(),
    ProfileView(),
    OrderView(),
    NotificationView(),
  ];
  void changeBodyOfHomeView(int index) {
    this.index = index;
    emit(ChangeBodyOfHomeViewSuccess());
  }
}

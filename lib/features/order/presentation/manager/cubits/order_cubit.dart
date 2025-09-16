import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fake_store/constant.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:fake_store/features/cart/data/models/cart_item_model.dart';
import 'package:fake_store/features/order/data/models/order_model.dart';
import 'package:fake_store/features/order/data/repos/order_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  @override
  void onChange(Change<OrderState> change) {
    log(change.toString());
    super.onChange(change);
  }

  OrderCubit() : super(OrderInitial());

  addOrder(OrderModel orderModel, String userId) async {
    emit(OrderAddedLoading());
    var res = await OrderRepoImpl().addOrder(orderModel, userId);
    res.fold(
      (failure) => emit(OrderAddedFailed(message: failure)),
      (r) => emit(OrderAddedSuccess()),
    );
  }

  getAllOrders(BuildContext context) async {
    emit(GetAllOrdersLoading());
    var res = await OrderRepoImpl().getAllOrders(
      jsonDecode(SharedPreferencesSinglton.getString(setUser))['id'],
    );
    res.fold(
      (failure) => emit(GetAllOrdersFailed(message: failure)),
      (r) => emit(
        GetAllOrdersSuccess(
          orders: r.map((e) => OrderModel.fromJson(e)).toList(),
        ),
      ),
    );
  }

  getSingleOrder({required String orderId, required String userId}) async {
    emit(GetSingleOrderLoading());
    var res = await OrderRepoImpl().getSingleOrder(
      orderId: orderId,
      userId: userId,
    );
    res.fold(
      (failure) => emit(GetSingleOrderFailed(failure)),
      (r) => emit(GetSingleOrderSuccess(r)),
    );
  }

  deleteOrder({required String orderId, required String userId}) async {
    var res = await OrderRepoImpl().deleteOrder(
      orderId: orderId,
      userId: userId,
    );
    res.fold(
      (failure) => emit(DeleteOrderFailed(failure)),
      (r) => emit(DeleteOrderSuccess()),
    );
  }

  updateAddress(AddressModel newAddress) {
    emit(UpdateAddressSuccess(newAddress: newAddress));
  }

  updateOrder({required OrderModel order, required userId}) async {
    emit(UpadateOrderLoading());
    var res = await OrderRepoImpl().updateOrder(
      orderId: order.orderId,
      userId: userId,
      order: order,
    );
    res.fold(
      (l) => emit(UpdateOrderFailed(error: l)),
      (r) => emit(UpdateOrderSuccess()),
    );
  }

  deleteProductFromOrderEdit({required List<CartItemModel> newProducts}) {
    emit(DeleteProductFromOrderEditSuccess(newProducts: newProducts));
  }

  updateProductQuantityFromOrderEdit({required newQuantity}) {
    // emit(state)
  }
}

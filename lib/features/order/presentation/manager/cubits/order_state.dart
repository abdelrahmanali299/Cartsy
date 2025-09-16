part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderAddedSuccess extends OrderState {}

class OrderAddedLoading extends OrderState {}

class OrderAddedFailed extends OrderState {
  final String message;
  OrderAddedFailed({required this.message});
}

class GetAllOrdersSuccess extends OrderState {
  final List<OrderModel> orders;
  GetAllOrdersSuccess({required this.orders});
}

class GetAllOrdersFailed extends OrderState {
  final String message;
  GetAllOrdersFailed({required this.message});
}

class GetAllOrdersLoading extends OrderState {}

class GetSingleOrderLoading extends OrderState {}

class GetSingleOrderSuccess extends OrderState {
  final OrderModel orderModel;
  GetSingleOrderSuccess(this.orderModel);
}

class GetSingleOrderFailed extends OrderState {
  final String error;
  GetSingleOrderFailed(this.error);
}

class DeleteOrderLoading extends OrderState {}

class DeleteOrderSuccess extends OrderState {}

class DeleteOrderFailed extends OrderState {
  final String error;
  DeleteOrderFailed(this.error);
}

class UpdateAddressSuccess extends OrderState {
  final AddressModel newAddress;

  UpdateAddressSuccess({required this.newAddress});
}

class UpdateOrderSuccess extends OrderState {
  UpdateOrderSuccess();
}

class UpdateOrderFailed extends OrderState {
  final String error;

  UpdateOrderFailed({required this.error});
}

class UpadateOrderLoading extends OrderState {}

class DeleteProductFromOrderEditSuccess extends OrderState {
  final List<CartItemModel> newProducts;

  DeleteProductFromOrderEditSuccess({required this.newProducts});
}

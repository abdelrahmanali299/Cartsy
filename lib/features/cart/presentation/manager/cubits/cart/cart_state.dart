part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class AddCartLoading extends CartState {}

class AddCartSuccess extends CartState {}

class AddCartError extends CartState {
  final String message;
  AddCartError(this.message);
}

class DeleteCartLoading extends CartState {}

class DeleteCartSuccess extends CartState {}

class DeleteCartError extends CartState {
  final String message;
  DeleteCartError(this.message);
}

class UpdateCartSuccess extends CartState {}

class UpdateCartError extends CartState {
  final String message;
  UpdateCartError(this.message);
}

class UpdateCartLoading extends CartState {}

class ReadCartError extends CartState {
  final String message;
  ReadCartError(this.message);
}

class ReadCartSuccess extends CartState {
  final List<Map<String, dynamic>>? cartItems;

  ReadCartSuccess(this.cartItems);
}

class ReadCartLoading extends CartState {}

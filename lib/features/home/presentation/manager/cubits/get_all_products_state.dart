part of 'get_all_products_cubit.dart';

@immutable
abstract class GetAllProductsState {}

class GetAllProductsInitial extends GetAllProductsState {}

class GetAllProductsLoading extends GetAllProductsState {}

class GetAllProductsSuccess extends GetAllProductsState {
  final List<ProductModel> products;

  GetAllProductsSuccess({required this.products});
}

class GetAllProductsFailure extends GetAllProductsState {
  final String errorMessage;

  GetAllProductsFailure({required this.errorMessage});
}

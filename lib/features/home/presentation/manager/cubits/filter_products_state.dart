part of 'filter_products_cubit.dart';

@immutable
abstract class FilterProductsState {}

class FilterProductsInitial extends FilterProductsState {}

class FilterProductsLoading extends FilterProductsState {}

class FilterProductsSuccess extends FilterProductsState {
  final List<ProductModel> products;
  FilterProductsSuccess(this.products);
}

class FilterProductsError extends FilterProductsState {
  final String error;
  FilterProductsError(this.error);
}

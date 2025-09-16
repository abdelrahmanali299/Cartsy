part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProductModel> filteredProducts;
  SearchSuccess(this.filteredProducts);
}

class SearchError extends SearchState {}

class ClearRecentSearchSuccess extends SearchState {}

class DeleteOneRecentProductSuccess extends SearchState {}

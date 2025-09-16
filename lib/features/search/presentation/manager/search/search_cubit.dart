import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  @override
  void onChange(Change<SearchState> change) {
    log(change.toString());
    super.onChange(change);
  }

  SearchCubit() : super(SearchInitial());

  List<ProductModel> products = [];
  filterProducts({required String productName}) {
    emit(SearchLoading());
    List<ProductModel> filteredProducts = [];
    for (var p in products) {
      if (p.title.toLowerCase().contains(productName.toLowerCase())) {
        filteredProducts.add(p);
      }
    }
    emit(SearchSuccess(filteredProducts));
  }

  List<ProductModel> recentProducts = [];
  clearRecentProducts() {
    recentProducts = [];
    emit(ClearRecentSearchSuccess());
  }

  deleteOneRecentProduct({required int index}) {
    recentProducts.removeAt(index);
    emit(DeleteOneRecentProductSuccess());
  }
}

import 'package:bloc/bloc.dart';
import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:meta/meta.dart';

part 'filter_products_state.dart';

class FilterProductsCubit extends Cubit<FilterProductsState> {
  FilterProductsCubit() : super(FilterProductsInitial());
  List<ProductModel> products = [];

  filterProducts({required String criteria}) {
    emit(FilterProductsLoading());
    try {
      List<ProductModel> filteredProducts = [];
      if (criteria == "title") {
        filteredProducts = [...products]
          ..sort((a, b) => a.title.compareTo(b.title));
      } else if (criteria == "high_price") {
        filteredProducts = [...products]
          ..sort((a, b) => b.price.compareTo(a.price)); // Descending
      } else if (criteria == "low_price") {
        filteredProducts = [...products]
          ..sort((a, b) => a.price.compareTo(b.price)); // Ascending
      }

      emit(FilterProductsSuccess(filteredProducts));
    } on Exception catch (e) {
      emit(FilterProductsError(e.toString()));
    }
  }
}

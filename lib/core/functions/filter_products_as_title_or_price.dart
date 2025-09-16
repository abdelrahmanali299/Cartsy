import 'package:fake_store/features/home/data/models/product_model.dart';

List<ProductModel> filterProducts({
  required String criteria,
  required List<ProductModel> products,
}) {
  List<ProductModel> filteredProducts = [];
  if (criteria == "title") {
    filteredProducts = [...products]
      ..sort((a, b) => a.title.compareTo(b.title));
  } else if (criteria == "price") {
    filteredProducts = [...products]
      ..sort((a, b) => a.price.compareTo(b.price));
  }

  return filteredProducts;
}

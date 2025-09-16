import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:fake_store/features/home/data/models/rating_model.dart';

getDummyProducts() {
  return List.generate(10, (e) {
    return ProductModel(
      id: 1,
      title: 'title',
      description: 'description',
      image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
      price: 5,
      category: 'category',
      rating: RatingModel(rate: 3, count: 3),
    );
  });
}

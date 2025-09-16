import 'package:dartz/dartz.dart';
import 'package:fake_store/features/home/data/models/product_model.dart';

abstract class ProductRepo {
  Future<Either<String, List<ProductModel>>> getAllProducts({
    required String path,
  });
}

import 'package:dartz/dartz.dart';
import 'package:fake_store/core/api/api_services.dart';
import 'package:fake_store/core/errors/exception.dart';
import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:fake_store/features/home/data/repos/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  ProductRepoImpl();
  @override
  Future<Either<String, List<ProductModel>>> getAllProducts({
    required String path,
  }) async {
    try {
      var res = await ApiServices.get(path: path);
      List<ProductModel> products = [];
      for (var p in res) {
        products.add(ProductModel.fromJson(p));
      }
      return right(products);
    } on ServerException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}

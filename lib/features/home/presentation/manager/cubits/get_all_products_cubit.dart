import 'package:bloc/bloc.dart';
import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:fake_store/features/home/data/repos/product_repo.dart';
import 'package:meta/meta.dart';

part 'get_all_products_state.dart';

class GetAllProductsCubit extends Cubit<GetAllProductsState> {
  GetAllProductsCubit(this.productRepo) : super(GetAllProductsInitial());
  final ProductRepo productRepo;
  List<ProductModel> productsList = [];
  getAllProducts({required String path}) async {
    emit(GetAllProductsLoading());
    await productRepo
        .getAllProducts(path: path)
        .then(
          (value) => value.fold(
            (errMessage) {
              print('================================');
              print(errMessage);
              print('================================');

              emit(GetAllProductsFailure(errorMessage: errMessage));
            },
            (products) {
              print(products);
              productsList = products;
              emit(GetAllProductsSuccess(products: products));
            },
          ),
        );
  }
}

import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:fake_store/features/cart/data/models/cart_item_model.dart';
import 'package:fake_store/features/cart/data/repos/cart_repo_impl.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  @override
  void onChange(Change<CartState> change) {
    log(change.toString());
    super.onChange(change);
  }

  CartCubit() : super(CartInitial());
  List<Map<String, dynamic>>? cartItems = [];

  addToCart({required CartItemModel cartItem}) async {
    emit(AddCartLoading());
    try {
      await CartRepoImpl().insertDataToCart(cartItem: cartItem);

      emit(AddCartSuccess());
    } catch (e) {
      emit(AddCartError(e.toString()));
    }
  }

  deleteFromCart({required productId}) async {
    emit(DeleteCartLoading());
    try {
      await CartRepoImpl().deleteProductFromCart(productId: productId);
      cartItems = cartItems!
          .where((element) => element['product_id'] != productId)
          .toList();
      emit(DeleteCartSuccess());
    } catch (e) {
      emit(DeleteCartError(e.toString()));
    }
  }

  updateProductQuantity({required CartItemModel cartItem}) async {
    emit(UpdateCartLoading());
    try {
      await CartRepoImpl().updateProductQuantity(cartItem: cartItem);
      cartItems = cartItems!
          .map(
            (element) => element['product_id'] == cartItem.productModel.id
                ? {...element, 'Pquantity': cartItem.quantity}
                : element,
          )
          .toList();
      emit(UpdateCartSuccess());
    } catch (e) {
      emit(UpdateCartError(e.toString()));
    }
  }

  readDataFromCart() async {
    emit(ReadCartLoading());
    try {
      List<Map<String, dynamic>>? res = await CartRepoImpl()
          .readAllDataFromCart();
      cartItems = res ?? [];
      emit(ReadCartSuccess(res));
    } catch (e) {
      emit(ReadCartError(e.toString()));
    }
  }

  clearCart() async {
    emit(DeleteCartLoading());
    try {
      await CartRepoImpl().clearCart();
      cartItems = [];

      emit(DeleteCartSuccess());
    } catch (e) {
      emit(DeleteCartError(e.toString()));
    }
  }
}

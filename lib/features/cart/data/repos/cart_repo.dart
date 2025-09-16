import 'package:fake_store/features/cart/data/models/cart_item_model.dart';

abstract class CartRepo {
  Future<int?> insertDataToCart({required CartItemModel cartItem});
  Future<List<Map<String, dynamic>>?> readAllDataFromCart();
  Future<int?> updateProductQuantity({required CartItemModel cartItem});
  Future<int?> deleteProductFromCart({required productId});
  Future clearCart();
}

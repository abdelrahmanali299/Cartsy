import 'package:fake_store/core/services/sql_service.dart';
import 'package:fake_store/features/cart/data/models/cart_item_model.dart';
import 'package:fake_store/features/cart/data/repos/cart_repo.dart';

class CartRepoImpl extends CartRepo {
  @override
  Future<int?> insertDataToCart({required CartItemModel cartItem}) async {
    var res = await SqlDbService.insertData(
      '''
  INSERT INTO cart (product_id, Pname, Pprice, Pimg, Pquantity)
  VALUES (?, ?, ?, ?, ?)
  ''',
      [
        cartItem.productModel.id,
        cartItem.productModel.title,
        cartItem.productModel.price,
        cartItem.productModel.image,
        cartItem.quantity,
      ],
    );

    return res;
  }

  @override
  Future<List<Map<String, dynamic>>?> readAllDataFromCart() async {
    var res = await SqlDbService.readData(''' 
  SELECT * FROM CART
  ''');
    return res;
  }

  @override
  Future<int?> updateProductQuantity({required CartItemModel cartItem}) async {
    var res = await SqlDbService.updateData(
      ''' 
  UPDATE cart SET Pquantity = ${cartItem.quantity} WHERE product_id = ${cartItem.productModel.id}''',
    );
    return res;
  }

  @override
  Future<int?> deleteProductFromCart({required productId}) {
    var res = SqlDbService.deleteData('''
    DELETE FROM cart WHERE product_id = $productId
    ''');
    return res;
  }

  @override
  Future clearCart() {
    var res = SqlDbService.deleteData(''' 
    DELETE  FROM cart
    ''');
    return res;
  }
}

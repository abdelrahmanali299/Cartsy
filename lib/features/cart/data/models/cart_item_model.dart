import 'package:fake_store/features/home/data/models/product_model.dart';

class CartItemModel {
  final ProductModel productModel;
  num? quantity;

  CartItemModel({this.quantity, required this.productModel});
  toJson() => {"product": productModel.toJson(), "quantity": quantity};

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    productModel: ProductModel.fromJson(json['product']),
    quantity: json['quantity'] ?? 1,
  );

  factory CartItemModel.fromSql(Map<String, dynamic> json) {
    return CartItemModel(
      productModel: ProductModel.fromSql(json),
      quantity: json['Pquantity'],
    );
  }
}

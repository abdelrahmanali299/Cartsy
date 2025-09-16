import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:fake_store/features/cart/data/models/cart_item_model.dart';

class OrderModel {
  final DateTime orderDate;
  final String orderId;
  List<CartItemModel> products;
  AddressModel? address;

  OrderModel({
    required this.orderDate,
    required this.products,
    required this.orderId,
    this.address,
  });

  toJson() => {
    'orderDate': orderDate.toString(),
    'orderId': orderId,
    'products': products.map((e) => e.toJson()).toList(),
    'address': address?.toJson(),
  };
  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    orderDate: DateTime.parse(json['orderDate']),
    orderId: json['orderId'],
    address: AddressModel.fromJson(json['address']),
    products: (json['products'] as List<dynamic>)
        .map((e) => CartItemModel.fromJson(e))
        .toList(),
  );
}

import 'dart:math';

import 'package:fake_store/core/api/end_points.dart';

class UserModel {
  String? name, email, password;
  String? uId;
  AddressModel? address;

  UserModel({this.name, this.email, this.password, this.address});
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json['username'],
    email: json['email'],
    password: json['password'],
  );
  toJson() => {
    ApiKeys.userName: name,
    ApiKeys.email: email,
    ApiKeys.password: password,
    ApiKeys.uId: uId,
    'address': address?.toJson(),
  };
}

int? setUserId() {
  return Random().nextInt(2 ^ 32);
}

class AddressModel {
  String? country, state, city, street;
  AddressModel({this.country, this.city, this.state, this.street});
  toJson() => {
    'country': country,
    'state': state,
    'city': city,
    'street': street,
  };
  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    country: json['country'],
    state: json['state'],
    city: json['city'],
    street: json['street'],
  );
}

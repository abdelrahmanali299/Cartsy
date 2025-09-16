import 'package:fake_store/features/home/data/models/rating_model.dart';

class ProductModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final num price;
  final String category;
  final dynamic rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
    required this.rating,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      category: json['category'],
      rating: json['rating'] != null
          ? RatingModel.fromJson(json['rating'])
          : null,
    );
  }
  factory ProductModel.fromSql(json) {
    return ProductModel(
      id: json['product_id'],
      title: json['Pname'],
      description: "",
      image: json['Pimg'],
      price: json['Pprice'],
      category: "",
      rating: RatingModel(rate: 0, count: 0),
    );
  }
  toSql() => {
    "product_id": id,
    "Pname": title,
    "Pimg": image,
    "Pprice": price,
    "Pquantity": 1,
  };
  toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
  };
}

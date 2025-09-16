class RatingModel {
  final num rate;
  final num count;

  RatingModel({required this.rate, required this.count});
  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      RatingModel(rate: json['rate'], count: json['count']);
}

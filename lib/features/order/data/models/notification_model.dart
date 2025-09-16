class NotificationModel {
  final String title;
  final String body;
  final int? id;
  final String orderId;
  DateTime date;

  NotificationModel(
    this.id, {
    required this.title,
    required this.body,
    required this.date, // DateTime.now(),
    required this.orderId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        json['id'],
        title: json['title'],
        body: json['body'],
        date: DateTime.parse(json['date']),
        orderId: json['orderId'],
      );
  toJson() => {
    'title': title,
    'body': body,
    'id': id,
    'date': date.toString(),
    'orderId': orderId,
  };
  static int generateNotificationId() =>
      DateTime.now().millisecondsSinceEpoch ~/ 1000;
}

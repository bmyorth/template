class NotificationModel {
  NotificationModel({
    this.id,
    this.title,
    this.message,
    this.read = false,
    this.active,
    this.date,
  });

  String? id;
  String? title;
  String? message;
  bool read;
  bool? active;
  String? date;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        read: json["read"] ?? false,
        active: json["active"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "message": message,
        "read": read,
        "active": active,
        "date": date
      };

  @override
  // ignore: hash_and_equals
  bool operator ==(other) {
    return (other is NotificationModel) && other.id == id;
  }
}

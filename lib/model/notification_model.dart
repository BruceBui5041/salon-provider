class NotificationModel {
  String? icon;
  String? title;
  String? time;
  String? message;
  List<String>? image;
  bool? isRead;

  NotificationModel(
      {this.icon,
        this.title,
        this.time,
        this.message,
        this.image,
        this.isRead});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    time = json['time'];
    message = json['message'];
    image = json['image'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['title'] = title;
    data['time'] = time;
    data['message'] = message;
    data['image'] = image;
    data['isRead'] = isRead;
    return data;
  }
}

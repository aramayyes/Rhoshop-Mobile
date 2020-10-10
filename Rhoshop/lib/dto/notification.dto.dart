class NotificationDto {
  String id;
  String message;
  DateTime date;

  NotificationDto({this.id, this.message, this.date});

  NotificationDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        message = json['message'],
        date = json.containsKey('date') ? DateTime.parse(json['date']) : null;
}

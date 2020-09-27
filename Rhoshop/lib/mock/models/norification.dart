class AppNotification {
  DateTime date;
  String content;
  String defaultContent;
  String localizedContent;

  AppNotification(this.date, this.defaultContent, this.localizedContent)
      : content = defaultContent;
}

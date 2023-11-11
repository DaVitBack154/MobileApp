class ReceivedNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;
  final String? imageUrl;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
    this.imageUrl,
  });
}

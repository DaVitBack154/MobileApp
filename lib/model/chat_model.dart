class ChatMessage {
  final String? sender;
  final String? message;
  final String? receiver;
  final String? type;
  final String? statusRead;
  final String? statusConnect;
  final String? idCard;
  final List<String>? images;

  ChatMessage({
    this.sender,
    this.message,
    this.receiver,
    this.type,
    this.statusRead,
    this.statusConnect,
    this.idCard,
    this.images,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      sender: json['sender'],
      message: json['message'],
      receiver: json['receiver'],
      type: json['type'],
      statusRead: json['status_read'],
      statusConnect: json['status_connect'],
      idCard: json['id_card'],
      images: json['image'] != null
          ? List<String>.from(json['image'])
          : [], // ตรวจสอบว่ามีค่าเป็น null หรือไม่
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'message': message,
      'receiver': receiver,
      'type': type,
      'status_read': statusRead,
      'status_connect': statusConnect,
      'id_card': idCard,
      'image': images,
    };
  }
}

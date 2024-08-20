// class ConversationUser {
//   final String? id;
//   final String? userSenderID;
//   final String? userReciverID;

//   ConversationUser({
//     this.id,
//     this.userSenderID,
//     this.userReciverID,
//   });

//   factory ConversationUser.fromJson(Map<String, dynamic> json) {
//     return ConversationUser(
//       id: json['_id'],
//       userSenderID: json['userSenderID'],
//       userReciverID: json['userReciverID'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id, // ส่งค่า id
//       'userSenderID': userSenderID,
//       'userReciverID': userReciverID,
//     };
//   }
// }

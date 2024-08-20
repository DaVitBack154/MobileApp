// class ChatUser {
//   final String? UserID; // เพิ่ม id
//   final String? name;
//   final String? surname;
//   final String? idCard;
//   final String? role;

//   ChatUser({
//     this.UserID, // เพิ่ม id
//     this.name,
//     this.surname,
//     this.idCard,
//     this.role,
//   });

//   factory ChatUser.fromJson(Map<String, dynamic> json) {
//     return ChatUser(
//       UserID: json['UserID'], // รับค่า id จาก json
//       name: json['name'],
//       surname: json['surname'],
//       idCard: json['idCard'],
//       role: json['role'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'UserID': UserID, // ส่งค่า id
//       'name': name,
//       'surname': surname,
//       'idCard': idCard,
//       'role': role,
//     };
//   }
// }

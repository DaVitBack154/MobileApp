import 'dart:convert';

class OtpModel {
  String? id;
  String? phone;
  String? otp;
  bool? status;

  OtpModel({
    this.id,
    this.phone,
    this.otp,
    this.status,
  });

  factory OtpModel.fromRawJson(String str) =>
      OtpModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        id: json["_id"],
        phone: json["phone"],
        otp: json["otp"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phone": phone,
        "otp": otp,
        "status": status,
      };
}

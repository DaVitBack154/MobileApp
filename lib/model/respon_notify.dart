import 'dart:convert';

class UserNotify {
  List<Datum>? data;

  UserNotify({
    this.data,
  });

  factory UserNotify.fromRawJson(String str) =>
      UserNotify.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserNotify.fromJson(Map<String, dynamic> json) => UserNotify(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  DateTime? notifyDate;
  String? personalId;
  String? customerId;
  String? companyId;
  String? title;
  DateTime? payDate;
  double? payAmount;
  String? flag;
  String? statusRead;

  Datum({
    this.id,
    this.notifyDate,
    this.personalId,
    this.customerId,
    this.companyId,
    this.title,
    this.payDate,
    this.payAmount,
    this.flag,
    this.statusRead,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        notifyDate: json["NotifyDate"] == null
            ? null
            : DateTime.parse(json["NotifyDate"]),
        personalId: json["PersonalID"],
        customerId: json["CustomerID"],
        companyId: json["CompanyID"],
        title: json["Title"],
        payDate:
            json["PayDate"] == null ? null : DateTime.parse(json["PayDate"]),
        payAmount: json["PayAmount"]?.toDouble(),
        flag: json["Flag"],
        statusRead: json["Status_Read"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "NotifyDate": notifyDate?.toIso8601String(),
        "PersonalID": personalId,
        "CustomerID": customerId,
        "CompanyID": companyId,
        "Title": title,
        "PayDate": payDate?.toIso8601String(),
        "PayAmount": payAmount,
        "Flag": flag,
        "Status_Read": statusRead,
      };
}

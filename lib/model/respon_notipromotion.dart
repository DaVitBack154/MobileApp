import 'dart:convert';

class NotiPromotion {
  List<Datum>? data;

  NotiPromotion({
    this.data,
  });

  factory NotiPromotion.fromRawJson(String str) =>
      NotiPromotion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotiPromotion.fromJson(Map<String, dynamic> json) => NotiPromotion(
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
  String? contractNo;
  String? titleNoti;
  String? bodyNoti;
  DateTime? datetimeNoti;
  DateTime? dateSave;
  String? statusRead;
  String? statusNoti;

  Datum({
    this.id,
    this.contractNo,
    this.titleNoti,
    this.bodyNoti,
    this.datetimeNoti,
    this.dateSave,
    this.statusRead,
    this.statusNoti,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        contractNo: json["contract_no"],
        titleNoti: json["title_noti"],
        bodyNoti: json["body_noti"],
        datetimeNoti: json["datetime_noti"] == null
            ? null
            : DateTime.parse(json["datetime_noti"]),
        dateSave: json["date_save"] == null
            ? null
            : DateTime.parse(json["date_save"]),
        statusRead: json["status_read"],
        statusNoti: json["status_noti"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "contract_no": contractNo,
        "title_noti": titleNoti,
        "body_noti": bodyNoti,
        "datetime_noti": datetimeNoti?.toIso8601String(),
        "date_save": dateSave?.toIso8601String(),
        "status_read": statusRead,
        "status_noti": statusNoti,
      };
}

import 'dart:convert';

class UserPromotion {
  List<Datum>? data;

  UserPromotion({
    this.data,
  });

  factory UserPromotion.fromRawJson(String str) =>
      UserPromotion.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserPromotion.fromJson(Map<String, dynamic> json) => UserPromotion(
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
  String? image;
  String? titlePro;
  String? contentPro;
  String? typeImage;
  String? status;
  String? expiredDate;

  Datum(
      {this.id,
      this.image,
      this.titlePro,
      this.contentPro,
      this.typeImage,
      this.status,
      this.expiredDate});

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        image: json["image"],
        titlePro: json["title_pro"],
        contentPro: json["content_pro"],
        typeImage: json["type_image"],
        status: json["status"],
        expiredDate: json["expired_date"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "title_pro": titlePro,
        "content_pro": contentPro,
        "type_image": typeImage,
        "status": status,
        "expired_date": expiredDate,
      };
}

import 'dart:convert';

class UserReq {
  Datareq? data;

  UserReq({
    this.data,
  });

  factory UserReq.fromRawJson(String str) => UserReq.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserReq.fromJson(Map<String, dynamic> json) => UserReq(
        data: json["data"] == null ? null : Datareq.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Datareq {
  String? id;
  String? name;
  String? surname;
  String? idCard;
  String? noContract;
  String? listReq;
  String? receiveNo;
  String? sentEmailuser;
  String? sentAddressuser;
  String? provin;
  String? district;
  String? subdistrict;
  String? postcode;
  String? other;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datareq({
    this.id,
    this.name,
    this.surname,
    this.idCard,
    this.noContract,
    this.listReq,
    this.receiveNo,
    this.sentEmailuser,
    this.sentAddressuser,
    this.provin,
    this.district,
    this.subdistrict,
    this.postcode,
    this.other,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datareq.fromRawJson(String str) => Datareq.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datareq.fromJson(Map<String, dynamic> json) => Datareq(
        id: json["_id"],
        name: json["name"],
        surname: json["surname"],
        idCard: json["id_card"],
        noContract: json["no_contract"],
        listReq: json["list_req"],
        receiveNo: json["receive_no"],
        sentEmailuser: json["sent_emailuser"],
        sentAddressuser: json["sent_addressuser"],
        provin: json["provin"],
        district: json["district"],
        subdistrict: json["subdistrict"],
        postcode: json["postcode"],
        other: json["other"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "surname": surname,
        "id_card": idCard,
        "no_contract": noContract,
        "list_req": listReq,
        "receive_no": receiveNo,
        "sent_emailuser": sentEmailuser,
        "sent_addressuser": sentAddressuser,
        "provin": provin,
        "district": district,
        "subdistrict": subdistrict,
        "postcode": postcode,
        "other": other,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

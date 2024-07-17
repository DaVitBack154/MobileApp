import 'dart:convert';

Payuser payuserFromJson(String str) => Payuser.fromJson(json.decode(str));

String payuserToJson(Payuser data) => json.encode(data.toJson());

class Payuser {
  Data data;

  Payuser({
    required this.data,
  });

  factory Payuser.fromJson(Map<String, dynamic> json) => Payuser(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  String? customerid;
  String? idCard;
  String? name;
  String? surname;
  String? company;
  String? status;

  Data({
    this.customerid,
    this.idCard,
    this.name,
    this.surname,
    this.company,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customerid: json["customerid"],
    idCard: json["id_card"],
    name: json["name"],
    surname: json["surname"],
    company: json["company"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "customerid": customerid,
    "id_card": idCard,
    "name": name,
    "surname": surname,
    "company": company,
    "status": status,
  };
}

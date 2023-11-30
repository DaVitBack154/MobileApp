import 'dart:convert';

class SaleHome {
  List<Datum>? data;

  SaleHome({
    this.data,
  });

  factory SaleHome.fromRawJson(String str) =>
      SaleHome.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaleHome.fromJson(Map<String, dynamic> json) => SaleHome(
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
  String? nameHome;
  String? province;
  String? locationHome;
  String? priceHome;
  String? detailHome;
  String? statusHome;
  List<String>? imgAll;

  Datum({
    this.id,
    this.nameHome,
    this.province,
    this.locationHome,
    this.priceHome,
    this.detailHome,
    this.statusHome,
    this.imgAll,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        nameHome: json["name_home"],
        province: json["province"],
        locationHome: json["location_home"],
        priceHome: json["price_home"],
        detailHome: json["detail_home"],
        statusHome: json["status_home"],
        imgAll: json["img_all"] == null
            ? []
            : List<String>.from(json["img_all"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name_home": nameHome,
        "province": province,
        "location_home": locationHome,
        "price_home": priceHome,
        "detail_home": detailHome,
        "status_home": statusHome,
        "img_all":
            imgAll == null ? [] : List<dynamic>.from(imgAll!.map((x) => x)),
      };
}

import 'dart:convert';

class CompanyModel {
  List<Datum>? data;

  CompanyModel({
    this.data,
  });

  factory CompanyModel.fromRawJson(String str) =>
      CompanyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
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
  String? companyId;
  String? tCompanyName;
  String? eCompanyName;
  String? companyTaxId;
  String? callCenter;
  String? emailCenter;
  String? lineAd;
  String? address;
  String? latitude;
  String? longitude;
  String? zoom;

  Datum({
    this.id,
    this.companyId,
    this.tCompanyName,
    this.eCompanyName,
    this.companyTaxId,
    this.callCenter,
    this.emailCenter,
    this.lineAd,
    this.address,
    this.latitude,
    this.longitude,
    this.zoom,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        companyId: json["CompanyID"],
        tCompanyName: json["TCompanyName"],
        eCompanyName: json["ECompanyName"],
        companyTaxId: json["CompanyTaxID"],
        callCenter: json["CallCenter"],
        emailCenter: json["EmailCenter"],
        lineAd: json["LineAd"],
        address: json["Address"],
        latitude: json["Laitude"],
        longitude: json["Longitude"],
        zoom: json["zoom"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "CompanyID": companyId,
        "TCompanyName": tCompanyName,
        "ECompanyName": eCompanyName,
        "CompanyTaxID": companyTaxId,
        "CallCenter": callCenter,
        "EmailCenter": emailCenter,
        "LineAd": lineAd,
        "Address": address,
        "Laitude": latitude,
        "Longitude": longitude,
        "zoom": zoom,
      };
}

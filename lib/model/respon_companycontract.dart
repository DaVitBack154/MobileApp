import 'dart:convert';

class CompanyContractModel {
  List<Datum>? data;

  CompanyContractModel({
    this.data,
  });

  factory CompanyContractModel.fromRawJson(String str) =>
      CompanyContractModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyContractModel.fromJson(Map<String, dynamic> json) =>
      CompanyContractModel(
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
  String? buyFrom;
  String? tBuyFromName;
  String? eBuyFromName;

  Datum({
    this.id,
    this.buyFrom,
    this.tBuyFromName,
    this.eBuyFromName,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        buyFrom: json["BuyFrom"],
        tBuyFromName: json["TBuyFromName"],
        eBuyFromName: json["EBuyFromName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "BuyFrom": buyFrom,
        "TBuyFromName": tBuyFromName,
        "EBuyFromName": eBuyFromName,
      };
}

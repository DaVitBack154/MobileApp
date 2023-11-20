import 'dart:convert';

UserAccModel userAccModelFromJson(String str) =>
    UserAccModel.fromJson(json.decode(str));

String userAccModelToJson(UserAccModel data) => json.encode(data.toJson());

class UserAccModel {
  final List<Datum>? data;

  UserAccModel({
    this.data,
  });

  factory UserAccModel.fromJson(Map<String, dynamic> json) => UserAccModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.map((x) => x.toJson()),
      };
}

class Datum {
  final String id;
  final String customerId;
  final String personalId;
  final String tCustomerTitle;
  final String tCustomerName;
  final String tCustomerSurname;
  final DateTime? birthDate;
  final String companyId;
  final String tCompanyName;
  final String companyTaxId;
  final String lineAd;
  final DateTime reportDate;
  final double osBalance;
  final DateTime lastPayDate;
  final double lastPayAmount;
  final String buyFrom;
  final String tBuyFromName;
  final String blockCode;
  final String flagCode;
  final double? portNo;
  final double? portNo2;
  final String refNo3;
  final DateTime reportAsOf;
  final bool deleted;
  final int v;

  Datum({
    required this.id,
    required this.customerId,
    required this.personalId,
    required this.tCustomerTitle,
    required this.tCustomerName,
    required this.tCustomerSurname,
    required this.birthDate,
    required this.companyId,
    required this.tCompanyName,
    required this.companyTaxId,
    required this.lineAd,
    required this.reportDate,
    required this.osBalance,
    required this.lastPayDate,
    required this.lastPayAmount,
    required this.buyFrom,
    required this.tBuyFromName,
    required this.blockCode,
    required this.flagCode,
    required this.portNo,
    required this.portNo2,
    required this.refNo3,
    required this.reportAsOf,
    required this.deleted,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        customerId: json["CustomerID"],
        personalId: json["PersonalID"],
        tCustomerTitle: json["TCustomerTitle"],
        tCustomerName: json["TCustomerName"],
        tCustomerSurname: json["TCustomerSurname"],
        birthDate: json["BirthDate"] == null
            ? null
            : DateTime.parse(json["BirthDate"]),
        companyId: json["CompanyID"],
        tCompanyName: json["TCompanyName"],
        companyTaxId: json["CompanyTaxID"],
        lineAd: json["LineAd"],
        reportDate: DateTime.parse(json["ReportDate"]),
        osBalance: json["OSBalance"]?.toDouble(),
        lastPayDate: DateTime.parse(json["LastPayDate"]),
        lastPayAmount: json["LastPayAmount"]?.toDouble(),
        buyFrom: json["BuyFrom"],
        tBuyFromName: json["TBuyFromName"],
        blockCode: json["BlockCode"],
        flagCode: json["FlagCode"],
        portNo: json["PortNo"]?.toDouble(),
        portNo2: json["PortNo2"]?.toDouble(),
        refNo3: json["RefNo3"],
        reportAsOf: DateTime.parse(json["ReportAsOf"]),
        deleted: json["deleted"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "CustomerID": customerId,
        "PersonalID": personalId,
        "TCustomerTitle": tCustomerTitle,
        "TCustomerName": tCustomerName,
        "TCustomerSurname": tCustomerSurname,
        "BirthDate": birthDate?.toIso8601String(),
        "CompanyID": companyId,
        "TCompanyName": tCompanyName,
        "CompanyTaxID": companyTaxId,
        "LineAd": lineAd,
        "ReportDate": reportDate.toIso8601String(),
        "OSBalance": osBalance,
        "LastPayDate": lastPayDate.toIso8601String(),
        "LastPayAmount": lastPayAmount,
        "BuyFrom": buyFrom,
        "TBuyFromName": tBuyFromName,
        "BlockCode": blockCode,
        "FlagCode": flagCode,
        "PortNo": portNo,
        "PortNo2": portNo2,
        "RefNo3": refNo3,
        "ReportAsOf": reportAsOf.toIso8601String(),
        "deleted": deleted,
        "__v": v,
      };
}

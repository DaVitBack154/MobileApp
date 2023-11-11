class UserPayment {
  List<Data>? data;

  UserPayment({this.data});

  UserPayment.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  String? payDate;
  String? entry;
  String? customerId;
  String? updatedDate;
  String? updatedTime;
  String? reportAsOf;
  double? payAmount;
  String? receiveDate;
  String? receiptNo;
  Data(
      {this.payDate,
      this.entry,
      this.customerId,
      this.updatedDate,
      this.updatedTime,
      this.reportAsOf,
      this.payAmount,
      this.receiveDate,
      this.receiptNo});

  Data.fromJson(Map<String, dynamic> json) {
    payDate = json["PayDate"];
    entry = json["Entry"];
    customerId = json["CustomerID"];
    updatedDate = json["UpdatedDate"];
    updatedTime = json["UpdatedTime"];
    reportAsOf = json["ReportAsOf"];
    payAmount = double.parse(json["PayAmount"].toString());
    receiveDate = json["ReceiveDate"];
    receiptNo = json["ReceiptNo"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["PayDate"] = payDate;
    _data["Entry"] = entry;
    _data["CustomerID"] = customerId;
    _data["UpdatedDate"] = updatedDate;
    _data["UpdatedTime"] = updatedTime;
    _data["ReportAsOf"] = reportAsOf;
    _data["PayAmount"] = payAmount;
    _data["ReceiveDate"] = receiveDate;
    _data["ReceiptNo"] = receiptNo;
    return _data;
  }
}

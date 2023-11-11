// ignore_for_file: no_leading_underscores_for_local_identifiers

class DefaultModel {
  bool? status;
  String? message;

  DefaultModel({this.status, this.message});

  DefaultModel.fromJson(Map<String, dynamic> json) {
    status = json["status"] ?? false;
    message = json["message"] ?? 'Server Filed';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    return _data;
  }
}

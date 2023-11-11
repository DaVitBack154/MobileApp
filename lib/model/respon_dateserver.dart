class DateServer {
  String? data;

  DateServer({this.data});

  DateServer.fromJson(Map<String, dynamic> json) {
    data = json["data"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["data"] = data;
    return _data;
  }
}

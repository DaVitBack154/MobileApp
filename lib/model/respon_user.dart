class UserModel {
  int? status;
  String? message;
  User? user;
  String? token;

  UserModel({this.status, this.message, this.user, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    user = json["user"] != null
        ? User.fromJson(json["user"])
        : json["data"] != null
            ? User.fromJson(json["data"])
            : null;
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["message"] = message;
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    _data["token"] = token;
    return _data;
  }
}

class User {
  String? id;
  String? gentname;
  String? name;
  String? surname;
  String? idCard;
  String? email;
  String? phone;
  String? pin;
  String? typeCustomer;
  String? sentAddressuser;
  String? provin;
  String? district;
  String? subdistrict;
  String? postcode;
  String? device;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.gentname,
    this.name,
    this.surname,
    this.idCard,
    this.email,
    this.phone,
    this.pin,
    this.typeCustomer,
    this.sentAddressuser,
    this.provin,
    this.district,
    this.subdistrict,
    this.postcode,
    this.device,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    gentname = json["gentname"];
    name = json["name"];
    surname = json["surname"];
    idCard = json["id_card"];
    email = json["email"];
    phone = json["phone"];
    pin = json["pin"];
    typeCustomer = json["type_customer"];
    sentAddressuser = json["sent_addressuser"];
    provin = json["provin"];
    district = json["district"];
    subdistrict = json["subdistrict"];
    postcode = json["postcode"];
    device = json["device"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["gentname"] = gentname;
    _data["name"] = name;
    _data["surname"] = surname;
    _data["id_card"] = idCard;
    _data["email"] = email;
    _data["phone"] = phone;
    _data["pin"] = pin;
    _data["type_customer"] = typeCustomer;
    _data["sent_addressuser"] = sentAddressuser;
    _data["provin"] = provin;
    _data["district"] = district;
    _data["subdistrict"] = subdistrict;
    _data["postcode"] = postcode;
    _data["device"] = device;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    return _data;
  }
}

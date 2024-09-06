import 'dart:convert';

import 'base_service.dart';

import 'package:http/http.dart';

class UserService extends BaseService {
  Future<Response> loginUser(
    String idCard,
    String? device,
  ) async {
    String url = '$domain/login';

    Response response = await post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id_card": idCard,
        "device": device,
      }),
    );

    return response;
  }

  Future<Response> registerUser({
    required String gentName,
    required String name,
    required String surName,
    required String idCard,
    required String email,
    required String phone,
    required String yomrub1,
    required String yomrub2,
    required String yomrub3,
    required String yomrub4,
    required String yomrub5,
    String? pin,
    String? device,
    String? platform,
  }) async {
    String url = '$domain/register';

    print('device post: $device');

    Response response = await post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "gent_name": gentName,
        "name": name,
        "surname": surName,
        "id_card": idCard,
        "email": email,
        "phone": phone,
        "pin": pin,
        "device": device,
        "platform": platform,
        "yomrub1": yomrub1,
        "yomrub2": yomrub2,
        "yomrub3": yomrub3,
        "yomrub4": yomrub4,
        "yomrub5": yomrub5,
      }),
    );
    return response;
  }

  Future<Response> getProfileUser(String token) async {
    String url = '$domain/getprofile';

    Response response = await get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "tokenmobile": token,
      },
    );
    return response;
  }

  Future<Response> updateProfile({
    required String id,
    required String? idCard,
    required String? email,
    required String? phone,
    required String? pin,
    required String? sentAddressuser,
    required String? district,
    required String? subdistrict,
    required String? provin,
    required String? postcode,
    String? statusStar,
  }) async {
    String url = '$domain/updateprofile/$id';

    Response response = await put(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: email != null
            ? jsonEncode({"email": email})
            : phone != null
                ? jsonEncode({"phone": phone})
                : pin != null
                    ? jsonEncode({"pin": pin})
                    : sentAddressuser != null
                        ? jsonEncode({
                            "sent_addressuser": sentAddressuser,
                            "district": district,
                            "subdistrict": subdistrict,
                            "provin": provin,
                            "postcode": postcode,
                          })
                        : statusStar != null
                            ? jsonEncode({
                                "status_star": statusStar,
                              })
                            : jsonEncode({}));

    return response;
  }

  Future<Response?> updateUserStar({
    required String id,
    required String? statusStar,
    required String? comment,
    required String? starPoint,
    required String? maidaiHai,
  }) async {
    String url = '$domain/updatestar/$id';

    Response response = await put(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "status_star": statusStar,
        "comment": comment,
        "starpoint": starPoint,
        "maihaipoint": maidaiHai,
      }),
    );

    return response;
  }

  Future<Response> getIdCardUser(String idCard) async {
    String url = '$domain/getid_card?id_card=$idCard';

    Response response = await get(Uri.parse(url));

    return response;
  }

  Future<Response> getPhoneUser(String phone) async {
    String url = '$domain/getphone?phone=$phone';

    Response response = await get(Uri.parse(url));

    return response;
  }

  Future<Response> getUserPayment(String token) async {
    String url = '$domain/gethistory_user';

    Response response = await get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "tokenmobile": token,
      },
    );
    return response;
  }

  Future<Response> getAccData(String token) async {
    String url = '$domain/getacc_user';

    Response response = await get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "tokenmobile": token,
      },
    );
    return response;
  }

  Future<Response> getDateServer() async {
    String url = '$domain/getdate_server';

    Response response = await get(
      Uri.parse(url),
    );
    return response;
  }

  Future<Response> createUserReq({
    required String name,
    required String surName,
    required String idCard,
    required String noContract,
    required String listReq,
    required String receiveNo,
    String? sentEmailuser,
    String? sentAddressuser,
    String? provin,
    String? district,
    String? subdistrict,
    String? postcode,
    String? other,
  }) async {
    String url = '$domain/create_requser';

    Response response = await post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "surname": surName,
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
      }),
    ); //ส่งอีที ต่อเรยครับ

    return response;
  }

  Future<Response> getNotify(String token) async {
    String url = '$domain/getnotify';

    Response response = await get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "tokenmobile": token,
      },
    );

    return response;
  }

  Future<Response> updateNotifyPay({
    String? token,
    required String? statusRead,
    required Map<String, dynamic> requestBody,
  }) async {
    try {
      String url = '$domain/updatepaynotify';
      Response response = await put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "tokenmobile": token.toString(),
        },
        body: jsonEncode({"Status_Read": statusRead}),
      );
      return response;
    } catch (e) {
      // print("Error ${e}");
      throw e;
    }
  }

  Future<Response> getPromotion(String token) async {
    String url = '$domain/promotion';

    Response response = await get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "tokenmobile": token,
      },
    );
    print(response); //อันนี้มา
    return response;
  }

  Future<Response> getUserAddress(String token) async {
    String url = '$domain/get_requserid';

    Response response = await get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "tokenmobile": token,
      },
    );
    return response;
  }

  Future<Response> getNotifyPromotion(String token) async {
    String url = '$domain/getnotify_id';

    Response response = await get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "tokenmobile": token,
      },
    );

    return response;
  }

  Future<Response> updateNotifyPromotion({
    String? token,
    required String? statusRead,
    required Map<String, dynamic> requestBody,
  }) async {
    try {
      String url = '$domain/updatenotify';
      Response response = await put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "tokenmobile": token.toString(),
        },
        body: jsonEncode({"status_read": statusRead}),
      );
      return response;
    } catch (e) {
      // print("Error ${e}");
      throw e;
    }
  }

  Future<Response> logout(
    String? token,
    String? device,
  ) async {
    String url = '$domain/logout';

    Response response = await put(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "tokenmobile": token.toString(),
      },
    );
    return response;
  }

  Future<Response> getSaleHome() async {
    String url = '$domain/getsalehome';

    Response response = await get(
      Uri.parse(url),
    );
    return response;
  }

  Future<Response> getSaleHomeID(String id) async {
    String url = '$domain/getsalehome/$id';

    Response response = await get(
      Uri.parse(url),
    );
    return response;
  }

  Future<Response> createPhoneOTP({
    required String phone,
    String? otp,
  }) async {
    String url = '$domain/request-otp';

    Response response = await post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone": phone,
        "otp": otp,
      }),
    );
    return response;
  }

  Future<Response> postOTP({
    required String phone,
    required String otp,
  }) async {
    String url = '$domain/verify-otp';
    Response response = await post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone": phone,
        "otp": otp,
      }),
    );
    return response;
  }

  Future<Response> getCompanyname() async {
    String url = '$domain/getcompany';

    Response response = await get(
      Uri.parse(url),
    );
    return response;
  }

  Future<Response> getCompanyContract() async {
    String url = '$domain/getcompany_contract';

    Response response = await get(
      Uri.parse(url),
    );
    return response;
  }

  Future<Response> createPayUser({
    String? customerId,
    String? idCard,
    String? name,
    String? surname,
    String? company,
    String? status,
  }) async {
    String url = '$domain/paymentuser';

    Response response = await post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "customerid": customerId,
        "id_card": idCard,
        "name": name,
        "surname": surname,
        "company": company,
        "status": status,
      }),
    );

    return response;
  }
}

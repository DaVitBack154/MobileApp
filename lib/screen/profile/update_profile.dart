import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/config/app_info.dart';
import 'package:mobile_chaseapp/screen/login_page/phone_page.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
// import 'package:mobile_chaseapp/screen/profile/edit_profile.dart';
// import 'package:mobile_chaseapp/utils/key_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/update_controller.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({
    super.key,
    this.phone = '',
    this.email = '',
    this.sentAddressuser = '',
    this.district = '',
    this.subdistrict = '',
    this.provin = '',
    this.postcode = '',
  });

  final String phone;
  final String email;
  final String sentAddressuser;
  final String district;
  final String subdistrict;
  final String provin;
  final String postcode;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _updateController = UpdateController();

  String? errorTextPhone;
  String? errorTextEmail;
  String? errorsentAddressuser;
  String? errordistrict;
  String? errorsubdistrict;
  String? errorprovin;
  String? errorpostcode;

  @override
  void initState() {
    super.initState();
    if (widget.phone.isNotEmpty) {
      _updateController.phoneController.text = widget.phone;
    }
    if (widget.email.isNotEmpty) {
      _updateController.emailController.text = widget.email;
    }
    if (widget.sentAddressuser.isNotEmpty) {
      _updateController.sentAddressuser.text = widget.sentAddressuser;
    }
    if (widget.district.isNotEmpty) {
      _updateController.district.text = widget.district;
    }
    if (widget.subdistrict.isNotEmpty) {
      _updateController.subdistrict.text = widget.subdistrict;
    }
    if (widget.provin.isNotEmpty) {
      _updateController.provin.text = widget.provin;
    }
    if (widget.postcode.isNotEmpty) {
      _updateController.postcode.text = widget.postcode;
    }
  }

  List provin = PROVINCE;
  List district = [];
  List subdistrict = [];
  List postcode = [];
  String? currentProvin;
  String? currentDistrict;
  String? currentSubdistrict;
  String? currentPostcode;
  String? nameProvin;
  String? nameDistrict;
  String? nameSubdistrict;
  String? namePostcode;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        // FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 11, 78, 74),
          foregroundColor: Colors.white,
          title: () {
            if (widget.phone.isNotEmpty) {
              return Text(
                'เบอร์โทรศัพท์',
                style: TextStyle(
                  fontSize: MyConstant.setMediaQueryWidth(context, 25),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            } else if (widget.email.isNotEmpty) {
              // กำหนด title ตามเงื่อนไขที่สอง
              return Text(
                'อีเมล',
                style: TextStyle(
                  fontSize: MyConstant.setMediaQueryWidth(context, 25),
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              // กำหนด title ตามเงื่อนไขที่สาม
              return Text(
                'ที่อยู่',
                style: TextStyle(
                  fontSize: MyConstant.setMediaQueryWidth(context, 25),
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          }(),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              //เบอร์โทร
              if (widget.phone.isNotEmpty)
                GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    // FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ).w,
                    child: TextField(
                      controller: _updateController.phoneController,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        // labelText: "เบอร์โทรศัพท์",
                        hintText: widget.phone,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Icon(
                            Icons.phone,
                            size: MyConstant.setMediaQueryWidth(context, 25),
                          ),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 30.sp,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey), // สีเมื่อไม่ Focus
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF103533),
                          ), // สีเมื่อ Focus
                        ),
                        errorText: errorTextPhone,
                      ),
                      cursorColor: Colors.grey.shade400,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        value.isEmpty || value.length < 10
                            ? errorTextPhone =
                                'กรุณากรอกเบอร์โทรศัพท์ให้ครบ 10 หลัก'
                            : errorTextPhone = null;
                        setState(() {});
                      },
                      style: TextStyle(fontSize: 23.sp),
                    ),
                  ),
                ),
              //eamil
              if (widget.email.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    // FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ).w,
                    child: TextField(
                      controller: _updateController.emailController,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        // labelText: "อีเมล",
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Icon(
                            Icons.email,
                            size: MyConstant.setMediaQueryWidth(context, 25),
                            color: Colors.grey.shade400,
                          ),
                        ),
                        hintText: widget.email,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(
                          fontSize: 30.sp,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey), // สีเมื่อไม่ Focus
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF103533),
                          ), // สีเมื่อ Focus
                        ),
                        errorText: errorTextEmail,
                      ),
                      cursorColor: Colors.grey.shade400,
                      onChanged: (value) {
                        value.isEmpty || value.length < 5
                            ? errorTextEmail = 'กรุณากรอกอีเมลให้ครบถ้วน'
                            : errorTextEmail = null;
                        setState(() {});
                      },
                      style: TextStyle(fontSize: 23.sp),
                    ),
                  ),
                ),
              //ที่อยู่
              if (widget.sentAddressuser.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    // FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ).w,
                    child: Column(
                      children: [
                        TextField(
                          controller: _updateController.sentAddressuser,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Icon(
                                Icons.location_on,
                                size:
                                    MyConstant.setMediaQueryWidth(context, 25),
                                color: Colors.grey.shade400,
                              ),
                            ),
                            hintText: widget.sentAddressuser,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                              fontSize: 30.sp,
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey), // สีเมื่อไม่ Focus
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF103533),
                              ), // สีเมื่อ Focus
                            ),
                            errorText: errorsentAddressuser,
                          ),
                          cursorColor: Colors.grey.shade400,
                          onChanged: (value) {
                            value.isEmpty || value.length < 5
                                ? errorsentAddressuser =
                                    'กรุณากรอกที่อยู่ให้ครบถ้วน'
                                : errorsentAddressuser = null;
                            setState(() {});
                          },
                          style: TextStyle(fontSize: 25.sp),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        selectPovinType(),
                        SizedBox(
                          height: 10.h,
                        ),
                        selectDistrict(),
                        SizedBox(
                          height: 10.h,
                        ),
                        selectSubdistrict(),
                        SizedBox(
                          height: 10.h,
                        ),
                        selectPostcode(),
                      ],
                    ),
                  ),
                ),

              // Text(widget.phone.toString()),
              // Text(widget.email.toString()),
              // Text(widget.sentAddressuser.toString()),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 30.h,
                  horizontal: 10.w,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (widget.phone.toString().isNotEmpty) {
                      if (_updateController.phoneController.text.length < 10) {
                        setState(() {
                          errorTextPhone;
                        });
                      } else {
                        if (_updateController.phoneController.text[0] == '0') {
                          await _updateController.fetchUpdateProfile(
                            phone: _updateController.phoneController.text,
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Phone_page(),
                            ),
                          );
                        } else {
                          setState(() {
                            errorTextPhone = 'เบอร์โทรศัพท์ไม่ถูกต้อง';
                          });
                        }
                      }
                    } else if (widget.email.toString().isNotEmpty) {
                      if (_updateController.emailController.text.isNotEmpty) {
                        if (!EmailValidator.validate(
                            _updateController.emailController.text)) {
                          setState(() {
                            errorTextEmail = 'กรุณากรอกรูปแบบ อีเมลให้ถูกต้อง';
                          });
                        } else {
                          await _updateController.fetchUpdateProfile(
                            email: _updateController.emailController.text,
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Phone_page(),
                            ),
                          );
                        }
                      }
                    } else {
                      if (_updateController.sentAddressuser.text.isNotEmpty) {
                        await _updateController.fetchUpdateProfile(
                            sentAddressuser:
                                _updateController.sentAddressuser.text,
                            provin: nameProvin ?? widget.provin.toString(),
                            district:
                                nameDistrict ?? widget.district.toString(),
                            subdistrict: nameSubdistrict ??
                                widget.subdistrict.toString(),
                            postcode:
                                namePostcode ?? widget.postcode.toString());
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Phone_page(),
                        ),
                      );
                    }

                    // if (_updateController.phoneController.text.isNotEmpty ||
                    //     _updateController.phoneController.text.length >= 10) {
                    //   await _updateController.fetchUpdateProfile(
                    //     phone: _updateController.phoneController.text,
                    //   );
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const Phone_page(),
                    //     ),
                    //   );
                    // } else if (_updateController
                    //     .emailController.text.isNotEmpty) {
                    //   if (!EmailValidator.validate(
                    //       _updateController.emailController.text)) {
                    //     setState(() {
                    //       errorTextEmail = 'กรุณากรอกรูปแบบ อีเมลให้ถูกต้อง';
                    //     });
                    //     return;
                    //   }
                    //   await _updateController.fetchUpdateProfile(
                    //     email: _updateController.emailController.text,
                    //   );
                    // } else if (_updateController
                    //     .sentAddressuser.text.isNotEmpty) {
                    //   await _updateController.fetchUpdateProfile(
                    //       sentAddressuser:
                    //           _updateController.sentAddressuser.text,
                    //       provin: nameProvin ?? widget.provin.toString(),
                    //       district: nameDistrict ?? widget.district.toString(),
                    //       subdistrict:
                    //           nameSubdistrict ?? widget.subdistrict.toString(),
                    //       postcode: namePostcode ?? widget.postcode.toString());
                    // }
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(width, 60),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFF103533), // กำหนดสีพื้นหลังของปุ่ม
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // กำหนดรัศมีของเส้นขอบปุ่ม
                      ),
                    ),
                  ),
                  child: Text(
                    'บันทึกข้อมูล',
                    style: TextStyle(
                      fontSize: MyConstant.setMediaQueryWidth(context, 25),
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectPovinType() => FormHelper.dropDownWidget(
        context,
        widget.provin,
        currentProvin,
        provin,
        (onChangedVal) {
          currentProvin = onChangedVal;
          debugPrint("เลือกจังหวัด = $onChangedVal");
          for (var province in provin) {
            if (province["id"].toString == onChangedVal.toString) {
              nameProvin = province["name"].toString();
              print(nameProvin);
            }
          }
          setState(() {
            district = DISTRICT
                .where((element) => element["parentid"] == currentProvin)
                .toList();
          });
        },
        (onValidateVal) {
          if (onValidateVal == null) {
            return "กรุณาเลือกจังหวัด";
          }
          return null;
        },
        borderColor: Colors.grey.shade300,
        borderFocusColor: Colors.grey.shade200,
        borderWidth: 1,
        borderRadius: 10,
        paddingLeft: 2,
        paddingRight: 2,
        hintFontSize: 18,
      );

  Widget selectDistrict() => FormHelper.dropDownWidget(
        context,
        widget.district,
        currentDistrict,
        district,
        (onChangedVal) {
          currentDistrict = onChangedVal;
          debugPrint("เลือกเขต = $onChangedVal");
          for (var districtLoop in district) {
            if (districtLoop["id"].toString == onChangedVal.toString) {
              nameDistrict = districtLoop["name"].toString();
              print(nameDistrict);
            }
          }
          setState(() {
            subdistrict = SUBDISTRICT
                .where((element) => element["parentid"] == currentDistrict)
                .toList();
          });
        },
        (onValidateVal) {
          if (onValidateVal == null) {
            return "กรุณาเลือกเขต";
          }
          return null;
        },
        borderColor: Colors.grey.shade300,
        borderFocusColor: Colors.grey.shade200,
        borderWidth: 1,
        borderRadius: 10,
        paddingLeft: 2,
        paddingRight: 2,
        hintFontSize: 18,
      );

  Widget selectSubdistrict() => FormHelper.dropDownWidget(
        context,
        widget.subdistrict,
        currentSubdistrict,
        subdistrict,
        (onChangedVal) {
          currentSubdistrict = onChangedVal;
          debugPrint("Selected YearMonth type = $onChangedVal");
          for (var subdistrictLoop in subdistrict) {
            if (subdistrictLoop["id"].toString == onChangedVal.toString) {
              nameSubdistrict = subdistrictLoop["name"].toString();
              print(nameSubdistrict);
            }
          }
          setState(() {
            postcode = POSTCODE
                .where((element) => element["parentid"] == currentSubdistrict)
                .toList();
          });
        },
        (onValidateVal) {
          if (onValidateVal == null) {
            return "กรุณาเลือกแขวง";
          }
          return null;
        },
        borderColor: Colors.grey.shade300,
        borderFocusColor: Colors.grey.shade200,
        borderWidth: 1,
        borderRadius: 10,
        paddingLeft: 2,
        paddingRight: 2,
        hintFontSize: 18,
      );

  Widget selectPostcode() => FormHelper.dropDownWidget(
        context,
        widget.postcode,
        currentPostcode,
        postcode,
        (onChangedVal) {
          currentPostcode = onChangedVal;
          debugPrint("Selected YearMonth type = $onChangedVal");
          for (var postcodetLoop in postcode) {
            if (postcodetLoop["id"].toString == onChangedVal.toString) {
              namePostcode = postcodetLoop["name"].toString();
              print(namePostcode);
            }
          }
          setState(() {});
        },
        (onValidateVal) {
          if (onValidateVal == null) {
            return "กรุณาเลือกรหัสไปรษณีย์";
          }
          return null;
        },
        borderColor: Colors.grey.shade300,
        borderFocusColor: Colors.grey.shade200,
        borderWidth: 1,
        borderRadius: 10,
        paddingLeft: 2,
        paddingRight: 2,
        hintFontSize: 18,
      );
}

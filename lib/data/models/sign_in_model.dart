import 'dart:convert';

SignUpResponseModel signUpResponseModelFromJson(String str) => SignUpResponseModel.fromJson(json.decode(str));

String signUpResponseModelToJson(SignUpResponseModel data) => json.encode(data.toJson());

class SignUpResponseModel {
  SignUpResponseModel({
    this.msg,
    this.data,
  });

  String? msg;
  Data? data;

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) => SignUpResponseModel(
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data?.toJson(),
  };
}

class Data {
  Data({
    this.member,
    this.token,
  });

  Member? member;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    member: json["member"] == null ? null : Member.fromJson(json["member"]),
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "member": member == null ? null : member?.toJson(),
    "token": token == null ? null : token,
  };
}

class Member {
  Member({
    this.lastName,
    this.firstName,
    this.phone,
    this.password,
    this.otp,
    this.avatar,
    this.passwordOtp,
    this.yearOfExperience,
    this.address,
    this.license,
    this.country,
    this.lga,
    this.state,
    this.officeAddress,
    this.officeCountry,
    this.officeState,
    this.officeLga,
    this.speciality,
    this.fcmToken,
    this.uuid,
    this.verified,
    this.availability,
    this.certified,
  });

  String? lastName;
  String? firstName;
  String? phone;
  String? password;
  String? otp;
  dynamic avatar;
  dynamic passwordOtp;
  dynamic yearOfExperience;
  dynamic address;
  dynamic license;
  dynamic country;
  dynamic lga;
  dynamic state;
  dynamic officeAddress;
  dynamic officeCountry;
  dynamic officeState;
  dynamic officeLga;
  dynamic speciality;
  dynamic fcmToken;
  String? uuid;
  bool? verified;
  List<dynamic>? availability;
  bool? certified;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    lastName: json["lastName"] == null ? null : json["lastName"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    phone: json["phone"] == null ? null : json["phone"],
    password: json["password"] == null ? null : json["password"],
    otp: json["otp"] == null ? null : json["otp"],
    avatar: json["avatar"],
    passwordOtp: json["passwordOTP"],
    yearOfExperience: json["yearOfExperience"],
    address: json["address"],
    license: json["license"],
    country: json["country"],
    lga: json["lga"],
    state: json["state"],
    officeAddress: json["officeAddress"],
    officeCountry: json["officeCountry"],
    officeState: json["officeState"],
    officeLga: json["officeLga"],
    speciality: json["speciality"],
    fcmToken: json["fcm_token"],
    uuid: json["uuid"] == null ? null : json["uuid"],
    verified: json["verified"] == null ? null : json["verified"],
    availability: json["availability"] == null ? null : List<dynamic>.from(json["availability"].map((x) => x)),
    certified: json["certified"] == null ? null : json["certified"],
  );

  Map<String, dynamic> toJson() => {
    "lastName": lastName == null ? null : lastName,
    "firstName": firstName == null ? null : firstName,
    "phone": phone == null ? null : phone,
    "password": password == null ? null : password,
    "otp": otp == null ? null : otp,
    "avatar": avatar,
    "passwordOTP": passwordOtp,
    "yearOfExperience": yearOfExperience,
    "address": address,
    "license": license,
    "country": country,
    "lga": lga,
    "state": state,
    "officeAddress": officeAddress,
    "officeCountry": officeCountry,
    "officeState": officeState,
    "officeLga": officeLga,
    "speciality": speciality,
    "fcm_token": fcmToken,
    "uuid": uuid == null ? null : uuid,
    "verified": verified == null ? null : verified,
    "availability": availability == null ? null : List<dynamic>.from(availability!.map((x) => x)),
    "certified": certified == null ? null : certified,
  };
}

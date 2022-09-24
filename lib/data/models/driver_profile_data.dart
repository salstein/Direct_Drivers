import 'dart:convert';

DriverProfileData driverProfileDataFromJson(String str) => DriverProfileData.fromJson(json.decode(str));

String driverProfileDataToJson(DriverProfileData data) => json.encode(data.toJson());

class DriverProfileData {
  DriverProfileData({
    this.msg,
    this.data,
  });

  String? msg;
  Data? data;

  factory DriverProfileData.fromJson(Map<String, dynamic> json) => DriverProfileData(
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
    this.uuid,
    this.avatar,
    this.lastName,
    this.firstName,
    this.phone,
    this.otp,
    this.verified,
    this.passwordOtp,
    this.dateOfBirth,
    this.language,
    this.guadianPhone,
    this.address,
    this.country,
    this.availability,
    this.lga,
    this.state,
    this.fcmToken,
  });

  String? uuid;
  dynamic avatar;
  String? lastName;
  String? firstName;
  String? phone;
  String? otp;
  bool? verified;
  dynamic passwordOtp;
  dynamic dateOfBirth;
  String? language;
  dynamic guadianPhone;
  String? address;
  String? country;
  bool? availability;
  String? lga;
  String? state;
  dynamic fcmToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    uuid: json["uuid"] == null ? null : json["uuid"],
    avatar: json["avatar"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    phone: json["phone"] == null ? null : json["phone"],
    otp: json["otp"] == null ? null : json["otp"],
    verified: json["verified"] == null ? null : json["verified"],
    passwordOtp: json["passwordOTP"],
    dateOfBirth: json["dateOfBirth"],
    language: json["language"] == null ? null : json["language"],
    guadianPhone: json["guadianPhone"],
    address: json["address"] == null ? null : json["address"],
    country: json["country"] == null ? null : json["country"],
    availability: json["availability"] == null ? null : json["availability"],
    lga: json["lga"] == null ? null : json["lga"],
    state: json["state"] == null ? null : json["state"],
    fcmToken: json["fcm_token"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "avatar": avatar,
    "lastName": lastName == null ? null : lastName,
    "firstName": firstName == null ? null : firstName,
    "phone": phone == null ? null : phone,
    "otp": otp == null ? null : otp,
    "verified": verified == null ? null : verified,
    "passwordOTP": passwordOtp,
    "dateOfBirth": dateOfBirth,
    "language": language == null ? null : language,
    "guadianPhone": guadianPhone,
    "address": address == null ? null : address,
    "country": country == null ? null : country,
    "availability": availability == null ? null : availability,
    "lga": lga == null ? null : lga,
    "state": state == null ? null : state,
    "fcm_token": fcmToken,
  };
}

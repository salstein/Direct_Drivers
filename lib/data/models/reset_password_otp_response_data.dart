import 'dart:convert';

ResetPasswordOtpResponseData resetPasswordOtpResponseDataFromJson(String str) => ResetPasswordOtpResponseData.fromJson(json.decode(str));

String resetPasswordOtpResponseDataToJson(ResetPasswordOtpResponseData data) => json.encode(data.toJson());

class ResetPasswordOtpResponseData {
  ResetPasswordOtpResponseData({
    this.msg,
    this.data,
  });

  String? msg;
  Data? data;

  factory ResetPasswordOtpResponseData.fromJson(Map<String, dynamic> json) => ResetPasswordOtpResponseData(
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
    this.token,
  });

  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
  };
}

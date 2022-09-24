import 'dart:convert';

TripResponseData tripResponseDataFromJson(String str) => TripResponseData.fromJson(json.decode(str));

String tripResponseDataToJson(TripResponseData data) => json.encode(data.toJson());

class TripResponseData {
  TripResponseData({
    this.msg,
    this.data,
  });

  String? msg;
  List<Trips>? data;

  factory TripResponseData.fromJson(Map<String, dynamic> json) => TripResponseData(
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<Trips>.from(json["data"].map((x) => Trips.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Trips {
  Trips({
    this.uuid,
    this.createdAt,
    this.status,
    this.pickupTime,
    this.dropoffTIme,
    this.pickupAddress,
    this.pickupLga,
    this.pickupState,
    this.dropOfAddress,
    this.redAlert,
  });

  String? uuid;
  DateTime? createdAt;
  String? status;
  dynamic pickupTime;
  dynamic dropoffTIme;
  String? pickupAddress;
  String? pickupLga;
  String? pickupState;
  String? dropOfAddress;
  RedAlert? redAlert;

  factory Trips.fromJson(Map<String, dynamic> json) => Trips(
    uuid: json["uuid"] == null ? null : json["uuid"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    status: json["status"] == null ? null : json["status"],
    pickupTime: json["pickupTime"],
    dropoffTIme: json["dropoffTIme"],
    pickupAddress: json["pickupAddress"] == null ? null : json["pickupAddress"],
    pickupLga: json["pickupLga"] == null ? null : json["pickupLga"],
    pickupState: json["pickupState"] == null ? null : json["pickupState"],
    dropOfAddress: json["dropOfAddress"] == null ? null : json["dropOfAddress"],
    redAlert: json["redAlert"] == null ? null : RedAlert.fromJson(json["redAlert"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
    "status": status == null ? null : status,
    "pickupTime": pickupTime == null ? null : pickupTime,
    "dropoffTIme": dropoffTIme == null ?  null : dropoffTIme,
    "pickupAddress": pickupAddress == null ? null : pickupAddress,
    "pickupLga": pickupLga == null ? null : pickupLga,
    "pickupState": pickupState == null ? null : pickupState,
    "dropOfAddress": dropOfAddress == null ? null : dropOfAddress,
    "redAlert": redAlert == null ? null : redAlert?.toJson(),
  };
}

class RedAlert {
  RedAlert({
    this.uuid,
    this.type,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.patient,
  });

  String? uuid;
  String? type;
  List<String>? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  Patient? patient;

  factory RedAlert.fromJson(Map<String, dynamic> json) => RedAlert(
    uuid: json["uuid"] == null ? null : json["uuid"],
    type: json["type"] == null ? null : json["type"],
    description: json["description"] == null ? null : List<String>.from(json["description"].map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    patient: json["patient"] == null ? null : Patient.fromJson(json["patient"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "type": type == null ? null : type,
    "description": description == null ? null : List<dynamic>.from(description!.map((x) => x)),
    "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "patient": patient == null ? null : patient?.toJson(),
  };
}

class Patient {
  Patient({
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
    this.pregnancyMonth,
    this.guadianPhone,
    this.address,
    this.country,
    this.lga,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.fcmToken,
  });

  String? uuid;
  String? avatar;
  String? lastName;
  String? firstName;
  String? phone;
  String? otp;
  bool? verified;
  String? passwordOtp;
  DateTime? dateOfBirth;
  String? language;
  String? pregnancyMonth;
  String? guadianPhone;
  String? address;
  String? country;
  String? lga;
  String? state;
  DateTime? createdAt;
  dynamic updatedAt;
  String? fcmToken;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    uuid: json["uuid"] == null ? null : json["uuid"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    phone: json["phone"] == null ? null : json["phone"],
    otp: json["otp"] == null ? null : json["otp"],
    verified: json["verified"] == null ? null : json["verified"],
    passwordOtp: json["passwordOTP"] == null ? null : json["passwordOTP"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    language: json["language"] == null ? null : json["language"],
    pregnancyMonth: json["pregnancyMonth"] == null ? null : json["pregnancyMonth"],
    guadianPhone: json["guadianPhone"] == null ? null : json["guadianPhone"],
    address: json["address"] == null ? null : json["address"],
    country: json["country"] == null ? null : json["country"],
    lga: json["lga"] == null ? null : json["lga"],
    state: json["state"] == null ? null : json["state"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"],
    fcmToken: json["fcm_token"] == null ? null : json["fcm_token"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "avatar": avatar == null ? null : avatar,
    "lastName": lastName == null ? null : lastName,
    "firstName": firstName == null ? null : firstName,
    "phone": phone == null ? null : phone,
    "otp": otp == null ? null : otp,
    "verified": verified == null ? null : verified,
    "passwordOTP": passwordOtp == null ? null : passwordOtp,
    "dateOfBirth": dateOfBirth == null ? null : "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
    "language": language == null ? null : language,
    "pregnancyMonth": pregnancyMonth == null ? null : pregnancyMonth,
    "guadianPhone": guadianPhone == null ? null : guadianPhone,
    "address": address == null ? null : address,
    "country": country == null ? null : country,
    "lga": lga == null ? null : lga,
    "state": state == null ? null : state,
    "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
    "updatedAt": updatedAt,
    "fcm_token": fcmToken == null ? null : fcmToken,
  };
}

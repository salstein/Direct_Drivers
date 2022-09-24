import 'dart:convert';

NotificationResponseData notificationResponseDataFromJson(String str) => NotificationResponseData.fromJson(json.decode(str));

String notificationResponseDataToJson(NotificationResponseData data) => json.encode(data.toJson());

class NotificationResponseData {
  NotificationResponseData({
    this.msg,
    this.data,
  });

  String? msg;
  List<Notification>? data;

  factory NotificationResponseData.fromJson(Map<String, dynamic> json) => NotificationResponseData(
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<Notification>.from(json["data"].map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Notification {
  Notification({
    this.uuid,
    this.title,
    this.body,
    this.read,
    this.createdAt,
    this.data,
    this.user,
  });

  String? uuid;
  String? title;
  String? body;
  bool? read;
  DateTime? createdAt;
  Data? data;
  String? user;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    uuid: json["uuid"] == null ? null : json["uuid"],
    title: json["title"] == null ? null : json["title"],
    body: json["body"] == null ? null : json["body"],
    read: json["read"] == null ? null : json["read"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    user: json["user"] == null ? null : json["user"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "title": title == null ? null : title,
    "body": body == null ? null : body,
    "read": read == null ? null : read,
    "createdAt": createdAt == null ? null : "${createdAt?.year.toString().padLeft(4, '0')}-${createdAt?.month.toString().padLeft(2, '0')}-${createdAt?.day.toString().padLeft(2, '0')}",
    "data": data == null ? null : data?.toJson(),
    "user": user == null ? null : user,
  };
}

class Data {
  Data({
    this.trip,
  });

  Trip? trip;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    trip: json["trip"] == null ? null : Trip.fromJson(json["trip"]),
  );

  Map<String, dynamic> toJson() => {
    "trip": trip == null ? null : trip?.toJson(),
  };
}

class Trip {
  Trip({
    this.uuid,
    this.driver,
    this.status,
    this.redAlert,
    this.createdAt,
    this.pickupLga,
    this.pickupTime,
    this.dropoffTIme,
    this.pickupState,
    this.dropOfAddress,
    this.pickupAddress,
  });

  String? uuid;
  Driver? driver;
  String? status;
  RedAlert? redAlert;
  DateTime? createdAt;
  String? pickupLga;
  DateTime? pickupTime;
  dynamic dropoffTIme;
  State? pickupState;
  dynamic dropOfAddress;
  String? pickupAddress;

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
    uuid: json["uuid"] == null ? null : json["uuid"],
    driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    status: json["status"] == null ? null : json["status"],
    redAlert: json["redAlert"] == null ? null : RedAlert.fromJson(json["redAlert"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    pickupLga: json["pickupLga"] == null ? null : json["pickupLga"],
    pickupTime: json["pickupTime"] == null ? null : DateTime.parse(json["pickupTime"]),
    dropoffTIme: json["dropoffTIme"],
    pickupState: json["pickupState"] == null ? null : stateValues.map[json["pickupState"]],
    dropOfAddress: json["dropOfAddress"],
    pickupAddress: json["pickupAddress"] == null ? null : json["pickupAddress"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid == null ? null : uuid,
    "driver": driver == null ? null : driver?.toJson(),
    "status": status == null ? null : status,
    "redAlert": redAlert == null ? null : redAlert?.toJson(),
    "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
    "pickupLga": pickupLga == null ? null : pickupLga,
    "pickupTime": pickupTime == null ? null : pickupTime?.toIso8601String(),
    "dropoffTIme": dropoffTIme,
    "pickupState": pickupState == null ? null : pickupState,
    "dropOfAddress": dropOfAddress,
    "pickupAddress": pickupAddress == null ? null : pickupAddress,
  };
}

class Driver {
  Driver({
    this.lga,
    this.otp,
    this.uuid,
    this.phone,
    this.state,
    this.avatar,
    this.address,
    this.country,
    this.language,
    this.lastName,
    this.verified,
    this.createdAt,
    this.fcmToken,
    this.firstName,
    this.updatedAt,
    this.dateOfBirth,
    this.passwordOtp,
    this.availability,
    this.guadianPhone,
    this.pregnancyMonth,
  });

  Lga? lga;
  String? otp;
  String? uuid;
  String? phone;
  State? state;
  String? avatar;
  Address? address;
  Country? country;
  Language? language;
  LastName? lastName;
  bool? verified;
  DateTime? createdAt;
  String? fcmToken;
  FirstName? firstName;
  dynamic updatedAt;
  DateTime? dateOfBirth;
  String? passwordOtp;
  bool? availability;
  String? guadianPhone;
  String? pregnancyMonth;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    lga: json["lga"] == null ? null : lgaValues.map[json["lga"]],
    otp: json["otp"] == null ? null : json["otp"],
    uuid: json["uuid"] == null ? null : json["uuid"],
    phone: json["phone"] == null ? null : json["phone"],
    state: json["state"] == null ? null : stateValues.map[json["state"]],
    avatar: json["avatar"] == null ? null : json["avatar"],
    address: json["address"] == null ? null : addressValues.map[json["address"]],
    country: json["country"] == null ? null : countryValues.map[json["country"]],
    language: json["language"] == null ? null : languageValues.map[json["language"]],
    lastName: json["lastName"] == null ? null : lastNameValues.map[json["lastName"]],
    verified: json["verified"] == null ? null : json["verified"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    fcmToken: json["fcm_token"] == null ? null : json["fcm_token"],
    firstName: json["firstName"] == null ? null : firstNameValues.map[json["firstName"]],
    updatedAt: json["updatedAt"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    passwordOtp: json["passwordOTP"] == null ? null : json["passwordOTP"],
    availability: json["availability"] == null ? null : json["availability"],
    guadianPhone: json["guadianPhone"] == null ? null : json["guadianPhone"],
    pregnancyMonth: json["pregnancyMonth"] == null ? null : json["pregnancyMonth"],
  );

  Map<String, dynamic> toJson() => {
    "lga": lga == null ? null : lga,
    "otp": otp == null ? null : otp,
    "uuid": uuid == null ? null : uuid,
    "phone": phone == null ? null : phone,
    "state": state == null ? null : state,
    "avatar": avatar == null ? null : avatar,
    "address": address == null ? null : address,
    "country": country == null ? null : country,
    "language": language == null ? null : language,
    "lastName": lastName == null ? null : lastName,
    "verified": verified == null ? null : verified,
    "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
    "fcm_token": fcmToken == null ? null : fcmToken,
    "firstName": firstName == null ? null : firstName,
    "updatedAt": updatedAt == null ? null : updatedAt,
    "dateOfBirth": dateOfBirth == null ? null : "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
    "passwordOTP": passwordOtp == null ? null : passwordOtp,
    "availability": availability == null ? null : availability,
    "guadianPhone": guadianPhone == null ? null : guadianPhone,
    "pregnancyMonth": pregnancyMonth == null ? null : pregnancyMonth,
  };
}

enum Address { OGUNSAMI, UMUNGASI }

final addressValues = EnumValues({
  "Ogunsami": Address.OGUNSAMI,
  "Umungasi": Address.UMUNGASI
});

enum Country { NIGERIA }

final countryValues = EnumValues({
  "Nigeria": Country.NIGERIA
});

enum FirstName { NNAYERE, JASON }

final firstNameValues = EnumValues({
  "Jason": FirstName.JASON,
  "Nnayere": FirstName.NNAYERE
});

enum Language { ENGLISH }

final languageValues = EnumValues({
  "English": Language.ENGLISH
});

enum LastName { CYPHER, VICTOR }

final lastNameValues = EnumValues({
  "Cypher": LastName.CYPHER,
  "Victor": LastName.VICTOR
});

enum Lga { SURULERE, ABA_NORTH }

final lgaValues = EnumValues({
  "Aba North": Lga.ABA_NORTH,
  "Surulere": Lga.SURULERE
});

enum State { LAGOS_STATE, ABIA_STATE }

final stateValues = EnumValues({
  "Abia State": State.ABIA_STATE,
  "Lagos State": State.LAGOS_STATE
});

class RedAlert {
  RedAlert({
    this.type,
    this.uuid,
    this.patient,
    this.createdAt,
    this.updatedAt,
    this.description,
  });

  String? type;
  String? uuid;
  Driver? patient;
  DateTime? createdAt;
  dynamic updatedAt;
  List<String>? description;

  factory RedAlert.fromJson(Map<String, dynamic> json) => RedAlert(
    type: json["type"] == null ? null : json["type"],
    uuid: json["uuid"] == null ? null : json["uuid"],
    patient: json["patient"] == null ? null : Driver.fromJson(json["patient"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"],
    description: json["description"] == null ? null : List<String>.from(json["description"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "uuid": uuid == null ? null : uuid,
    "patient": patient == null ? null : patient?.toJson(),
    "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
    "updatedAt": updatedAt,
    "description": description == null ? null : List<dynamic>.from(description!.map((x) => x)),
  };
}

enum Description { SEVERE_HEADACHES_WITH_BLURRED_VISION, FEVER_AND_TOO_WEAK_TO_GET_OUT_OF_BED, SWELLING_OF_FINGER_FACE_AND_LEGS }

final descriptionValues = EnumValues({
  "Fever and Too Weak To Get Out of Bed.": Description.FEVER_AND_TOO_WEAK_TO_GET_OUT_OF_BED,
  "Severe Headaches With Blurred Vision": Description.SEVERE_HEADACHES_WITH_BLURRED_VISION,
  "Swelling of Finger Face and Legs": Description.SWELLING_OF_FINGER_FACE_AND_LEGS
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

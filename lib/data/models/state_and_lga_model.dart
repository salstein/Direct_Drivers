import 'dart:convert';

List<StateAndLocalGovtModel> stateAndLocalGovtModelFromJson(String str) => List<StateAndLocalGovtModel>.from(json.decode(str).map((x) => StateAndLocalGovtModel.fromJson(x)));

String stateAndLocalGovtModelToJson(List<StateAndLocalGovtModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StateAndLocalGovtModel {
  StateAndLocalGovtModel({
    required this.state,
  });

  State state;

  factory StateAndLocalGovtModel.fromJson(Map<String, dynamic> json) => StateAndLocalGovtModel(
    state: State.fromJson(json["state"]),
  );

  Map<String, dynamic> toJson() => {
    "state": state.toJson(),
  };
}

class State {
  State({
    required this.capital,
    required this.name,
    required this.id,
    required this.locals,
  });

  String capital;
  String name;
  int id;
  List<Local> locals;

  factory State.fromJson(Map<String, dynamic> json) => State(
    capital: json["capital"],
    name: json["name"],
    id: json["id"],
    locals: List<Local>.from(json["locals"].map((x) => Local.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "capital": capital,
    "name": name,
    "id": id,
    "locals": List<dynamic>.from(locals.map((x) => x.toJson())),
  };
}

class Local {
  Local({
    required this.name,
    required this.id,
  });

  String name;
  int id;

  factory Local.fromJson(Map<String, dynamic> json) => Local(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}

// To parse this JSON data, do
//
//     final demande = demandeFromJson(jsonString);

import 'dart:convert';

Demande demandeFromJson(String str) => Demande.fromJson(json.decode(str));

String demandeToJson(Demande data) => json.encode(data.toJson());

class Demande {
  Demande({
    required this.demandes,
  });

  List<DemandeElement> demandes;

  factory Demande.fromJson(Map<String, dynamic> json) => Demande(
        demandes: List<DemandeElement>.from(
            json["demandes"].map((x) => DemandeElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "demandes": List<dynamic>.from(demandes.map((x) => x.toJson())),
      };
}

class DemandeElement {
  DemandeElement({
    required this.needTransport,
    required this.title,
    required this.category,
    required this.type,
    required this.formule,
    required this.email,
    required this.engagementManager,
    required this.engagementPartner,
    required this.country,
    required this.city,
    required this.date,
    required this.comment,
  });

  bool needTransport;
  String title;
  String category;
  String type;
  String formule;
  String email;
  String engagementManager;
  String engagementPartner;
  String country;
  String city;
  DateTime date;
  String comment;

  factory DemandeElement.fromJson(Map<String, dynamic> json) => DemandeElement(
        needTransport: json["needTransport"],
        title: json["title"],
        category: json["category"],
        type: json["type"],
        formule: json["formule"],
        email: json["email"],
        engagementManager: json["engagementManager"],
        engagementPartner: json["engagementPartner"],
        country: json["country"],
        city: json["city"],
        date: DateTime.parse(json["date"]),
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "needTransport": needTransport.toString(),
        "title": title,
        "category": category,
        "type": type,
        "formule": formule,
        "email": email,
        "engagementManager": engagementManager,
        "engagementPartner": engagementPartner,
        "country": country,
        "city": city,
        "date": date.toIso8601String(),
        "comment": comment,
      };
}

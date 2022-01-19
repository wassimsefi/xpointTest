// To parse this JSON data, do
//
//     final demande = demandeFromJson(jsonString);

import 'dart:convert';

List<Demande> demandeFromJson(String str) =>
    List<Demande>.from(json.decode(str).map((x) => Demande.fromJson(x)));

String demandeToJson(List<Demande> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Demande {
  Demande({
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

  factory Demande.fromJson(Map<String, dynamic> json) => Demande(
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
        "needTransport": needTransport,
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

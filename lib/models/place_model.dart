import 'dart:convert';

import 'package:social_eaters/models/user_model.dart';

class Place {
  String menuUrl;
  String? name;
  String? userComment;
  DateTime dateVisited;
  double? latitude;
  double? longtitude;
  String? id;
  UserModel? user;

  Place({
    required this.menuUrl,
    this.name,
    this.userComment,
    required this.dateVisited,
    this.latitude,
    this.longtitude,
    this.id,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'menuUrl': menuUrl,
      'name': name,
      'comment': userComment,
      'dateVisited': dateVisited.toString(),
      'latitude': latitude,
      'longtitude': longtitude,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      menuUrl: map['menuUrl'] ?? '',
      name: map['name'],
      userComment: map['userComment'],
      dateVisited: DateTime.parse(map['dateVisited']),
      latitude: map['latitude'],
      longtitude: map['longtitude'],
      id: map['id'],
      user: map['userCreated'] != null
          ? UserModel.fromMap(map['userCreated'][0])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source));
}

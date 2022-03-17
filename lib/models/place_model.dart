import 'dart:convert';

class Place {
  String menuUrl;
  String name;
  String? userComment;
  DateTime dateVisited;
  //TODO NULL
  double? latitude;
  double? longitude;

  Place({
    required this.menuUrl,
    required this.name,
    this.userComment,
    required this.dateVisited,
    required this.latitude,
    required this.longitude,
  });

  Place copyWith({
    String? menuUrl,
    String? name,
    String? userComment,
    DateTime? dateVisited,
    double? latitude,
    double? longitude,
  }) {
    return Place(
      menuUrl: menuUrl ?? this.menuUrl,
      name: name ?? this.name,
      userComment: userComment ?? this.userComment,
      dateVisited: dateVisited ?? this.dateVisited,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'menuUrl': menuUrl,
      'name': name,
      'userComment': userComment,
      'dateVisited': dateVisited.millisecondsSinceEpoch,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      menuUrl: map['menuUrl'] ?? '',
      name: map['name'] ?? '',
      userComment: map['userComment'],
      dateVisited: DateTime.fromMillisecondsSinceEpoch(map['dateVisited']),
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Place(menuUrl: $menuUrl, name: $name, userComment: $userComment, dateVisited: $dateVisited, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Place &&
        other.menuUrl == menuUrl &&
        other.name == name &&
        other.userComment == userComment &&
        other.dateVisited == dateVisited &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return menuUrl.hashCode ^
        name.hashCode ^
        userComment.hashCode ^
        dateVisited.hashCode ^
        latitude.hashCode ^
        longitude.hashCode;
  }
}

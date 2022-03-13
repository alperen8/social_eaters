import 'dart:convert';

class Place {
  String menuUrl;
  String name;
  String? userComment;
  DateTime dateVisited;

  Place({
    required this.menuUrl,
    required this.name,
    this.userComment,
    required this.dateVisited,
  });

  Place copyWith({
    String? menuUrl,
    String? name,
    String? userComment,
    DateTime? dateVisited,
  }) {
    return Place(
      menuUrl: menuUrl ?? this.menuUrl,
      name: name ?? this.name,
      userComment: userComment ?? this.userComment,
      dateVisited: dateVisited ?? this.dateVisited,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'menuUrl': menuUrl,
      'name': name,
      'userComment': userComment,
      'dateVisited': dateVisited.millisecondsSinceEpoch,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      menuUrl: map['menuUrl'] ?? '',
      name: map['name'] ?? '',
      userComment: map['userComment'],
      dateVisited: DateTime.fromMillisecondsSinceEpoch(map['dateVisited']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Place(menuUrl: $menuUrl, name: $name, userComment: $userComment, dateVisited: $dateVisited)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Place &&
        other.menuUrl == menuUrl &&
        other.name == name &&
        other.userComment == userComment &&
        other.dateVisited == dateVisited;
  }

  @override
  int get hashCode {
    return menuUrl.hashCode ^
        name.hashCode ^
        userComment.hashCode ^
        dateVisited.hashCode;
  }
}

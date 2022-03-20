import 'dart:convert';

class UserModel {
  String id;
  String firebaseId;
  String? name;
  String? surname;
  String? mail;
  int? status;
  UserModel({
    required this.id,
    required this.firebaseId,
    required this.name,
    required this.surname,
    this.mail,
    this.status,
  });

  UserModel copyWith({
    String? id,
    String? firebaseId,
    String? name,
    String? surname,
    String? mail,
    int? status,
  }) {
    return UserModel(
      id: id ?? this.id,
      firebaseId: firebaseId ?? this.firebaseId,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      mail: mail ?? this.mail,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firebaseId': firebaseId,
      'name': name,
      'surname': surname,
      'mail': mail,
      'status': status,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      firebaseId: map['firebaseId'] ?? '',
      name: map['name'],
      surname: map['surname'],
      mail: map['mail'],
      status: map['status']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, firebaseId: $firebaseId, name: $name, surname: $surname, mail: $mail, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.firebaseId == firebaseId &&
        other.name == name &&
        other.surname == surname &&
        other.mail == mail &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firebaseId.hashCode ^
        name.hashCode ^
        surname.hashCode ^
        mail.hashCode ^
        status.hashCode;
  }
}

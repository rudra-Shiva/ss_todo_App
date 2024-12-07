import 'dart:convert';

import 'package:todo_app/domain/entity/user/user_entity.dart';

/// id : "id"
/// name : "name"
/// email : "email"
/// password : "password"
/// timeStamp : "timeStamp"

UserDto userDtoFromJson(String str) => UserDto.fromJson(json.decode(str));
String userDtoToJson(UserDto data) => json.encode(data.toJson());

class UserDto {
  UserDto({
    this.id,
    this.name,
    this.email,
    this.password,
    this.timeStamp,
  });

  UserDto.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    timeStamp = json['timeStamp'];
  }
  String? id;
  String? name;
  String? email;
  String? password;
  String? timeStamp;
  UserDto copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? timeStamp,
  }) =>
      UserDto(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        timeStamp: timeStamp ?? this.timeStamp,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['timeStamp'] = timeStamp;
    return map;
  }

  // Convert to a Firestore-compatible Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'timeStamp': timeStamp
    };
  }

// Convert from FireStore Map to UserDTO
  factory UserDto.fromMap(Map<String, dynamic> map, String documentId) {
    return UserDto(
      id: documentId,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      timeStamp: map['timeStamp'] as String,
    );
  }

  // Convert UserDTO to User (Domain Model)
  UserEntity toDomain() {
    return UserEntity(
        id: id ?? "",
        name: name ?? "",
        email: email ?? "",
        password: password ?? "",
        timeStamp: timeStamp ?? "");
  }

  // Convert User (Domain Model) to UserDTO
  factory UserDto.fromDomain(UserEntity user) {
    return UserDto(
        id: user.id,
        name: user.name,
        email: user.email,
        password: user.password,
        timeStamp: user.timeStamp);
  }
}

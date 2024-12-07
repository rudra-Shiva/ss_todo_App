//also known as model

class UserEntity {
  dynamic id;
  final String name;
  final String email;
  final String password;
  final String timeStamp;

  UserEntity({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.timeStamp,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? timeStamp,
  }) =>
      UserEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        timeStamp: timeStamp ?? this.timeStamp,
      );
}

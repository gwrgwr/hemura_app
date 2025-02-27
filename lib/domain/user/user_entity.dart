class UserEntity {
  String token;
  String id;
  String email;
  String name;
  String lastName;

  UserEntity({
    required this.token,
    required this.id,
    required this.email,
    required this.name,
    required this.lastName,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserEntity &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          id == other.id &&
          email == other.email &&
          name == other.name &&
          lastName == other.lastName);

  @override
  int get hashCode =>
      token.hashCode ^
      id.hashCode ^
      email.hashCode ^
      name.hashCode ^
      lastName.hashCode;

  @override
  String toString() {
    return 'UserEntity{' +
        ' token: $token,' +
        ' id: $id,' +
        ' email: $email,' +
        ' name: $name,' +
        ' lastName: $lastName,' +
        '}';
  }

  UserEntity copyWith({
    String? token,
    String? id,
    String? email,
    String? name,
    String? lastName,
  }) {
    return UserEntity(
      token: token ?? this.token,
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'id': id,
      'email': email,
      'name': name,
      'lastName': lastName,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      token: map['token'] as String,
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      lastName: map['lastName'] as String,
    );
  }
}
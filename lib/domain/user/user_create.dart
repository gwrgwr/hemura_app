class UserCreate {
  String name;
  String lastName;
  String email;
  String password;

  UserCreate({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserCreate &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          lastName == other.lastName &&
          email == other.email &&
          password == other.password);

  @override
  int get hashCode =>
      name.hashCode ^ lastName.hashCode ^ email.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'UserCreate{' +
        ' name: $name,' +
        ' lastName: $lastName,' +
        ' email: $email,' +
        ' password: $password,' +
        '}';
  }

  UserCreate copyWith({
    String? token,
    String? name,
    String? lastName,
    String? email,
    String? password,
  }) {
    return UserCreate(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }

  factory UserCreate.fromMap(Map<String, dynamic> map) {
    return UserCreate(
      name: map['name'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}

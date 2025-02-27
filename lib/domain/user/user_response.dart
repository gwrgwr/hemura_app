class UserResponse {
  String id;
  String name;
  String finalName;
  String email;

  //<editor-fold desc="Data Methods">
  UserResponse({
    required this.id,
    required this.name,
    required this.finalName,
    required this.email,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserResponse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          finalName == other.finalName &&
          email == other.email);

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ finalName.hashCode ^ email.hashCode;

  @override
  String toString() {
    return 'UserResponse{' +
        ' id: $id,' +
        ' name: $name,' +
        ' finalName: $finalName,' +
        ' email: $email,' +
        '}';
  }

  UserResponse copyWith({
    String? id,
    String? name,
    String? finalName,
    String? email,
  }) {
    return UserResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      finalName: finalName ?? this.finalName,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'finalName': this.finalName,
      'email': this.email,
    };
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      id: map['id'] as String,
      name: map['name'] as String,
      finalName: map['finalName'] as String,
      email: map['email'] as String,
    );
  }

  //</editor-fold>
}
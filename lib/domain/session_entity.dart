import 'package:hemura/domain/task_entity.dart';
import 'package:hemura/domain/user/user_response.dart';

class SessionEntity {
  String id;
  String name;
  String code;
  List<UserResponse> users;
  List<TaskEntity> tasks;

  //<editor-fold desc="Data Methods">
  SessionEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.users,
    required this.tasks,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          code == other.code &&
          users == other.users &&
          tasks == other.tasks);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      code.hashCode ^
      users.hashCode ^
      tasks.hashCode;

  @override
  String toString() {
    return 'SessionEntity{' +
        ' id: $id,' +
        ' name: $name,' +
        ' code: $code,' +
        ' users: $users,' +
        ' tasks: $tasks,' +
        '}';
  }

  SessionEntity copyWith({
    String? id,
    String? name,
    String? code,
    List<UserResponse>? users,
    List<TaskEntity>? tasks,
  }) {
    return SessionEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      users: users ?? this.users,
      tasks: tasks ?? this.tasks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'code': this.code,
      'users': this.users,
      'tasks': this.tasks,
    };
  }

  factory SessionEntity.fromMap(Map<String, dynamic> map) {
    return SessionEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      code: map['code'] as String,
      users: (map['users'] as List<dynamic>?)
          ?.map((user) => UserResponse.fromMap(user as Map<String, dynamic>))
          .toList() ?? [],
      tasks: (map['tasks'] as List<dynamic>?)
          ?.map((task) => TaskEntity.fromMap(task as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  //</editor-fold>
}
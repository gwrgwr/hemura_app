import 'dart:convert';

class TaskEntity {
  String id;
  String title;
  String description;
  bool isCompleted;
  String weekDay;
  String time;

  //<editor-fold desc="Data Methods">
  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.weekDay,
    required this.time,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          isCompleted == other.isCompleted &&
          weekDay == other.weekDay &&
          time == other.time);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      isCompleted.hashCode ^
      weekDay.hashCode ^
      time.hashCode;

  @override
  String toString() {
    return 'TaskEntity{' +
        ' id: $id,' +
        ' title: $title,' +
        ' description: $description,' +
        ' isCompleted: $isCompleted,' +
        ' weekDay: $weekDay,' +
        ' time: $time,' +
        '}';
  }

  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    String? weekDay,
    String? time,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      weekDay: weekDay ?? this.weekDay,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'isCompleted': this.isCompleted,
      'weekDay': this.weekDay,
      'time': this.time,
    };
  }

  factory TaskEntity.fromMap(Map<String, dynamic> map) {
    return TaskEntity(
      id: map['id'] as String,
      title: utf8.decode((map['title'] as String).codeUnits),
      description: utf8.decode((map['description'] as String).codeUnits),
      isCompleted: map['isCompleted'] as bool,
      weekDay: map['weekDay'] as String,
      time: map['time'] as String,
    );
  }

  //</editor-fold>
}
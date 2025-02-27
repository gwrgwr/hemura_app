import 'package:hemura/data/repositories/task_repository.dart';
import 'package:hemura/data/services/sharedpreferences_services.dart';
import 'package:hemura/domain/session_entity.dart';
import 'package:hemura/domain/task_entity.dart';
import 'package:hemura/utils/commander.dart';

import '../../utils/result.dart';

class TaskViewModel {
  TaskViewModel() {
    getTasksByWeekday = Command0(_getTasksByWeekday)..execute();
    createTask = Command1(_createTask);
  }
  final repository = TaskRepository();

  List<TaskEntity> taskList = [];

  TaskEntity? taskEntity;

  late final Command0<void> getTasksByWeekday;

  late final Command1<void, (String title, String description, String weekday, String time)> createTask;

  Future<Result<void>> _getTasksByWeekday() async {
    final SharedPreferencesService prefs = SharedPreferencesService();
    final sessionEntity = await prefs.getSessions();
    switch (sessionEntity) {
      case Ok<SessionEntity>():
        final tasks = await repository.getTasks(sessionId: sessionEntity.value.id);
        switch (tasks) {
          case Ok<List<TaskEntity>>():
            taskList = tasks.value;
            print(taskList[10]);
            return Result.ok(null);
          case Error<List<TaskEntity>>():
            return Result.error(tasks.error);
        }
      case Error<SessionEntity>():
        return Result.error(sessionEntity.error);
    }
  }

  Future<Result<void>> _createTask((String title, String description, String weekday, String time) taskInfo) async {
    final (title, description, weekday, time) = taskInfo;
    final result = await repository.createTask(title, description, weekday, time);
    switch (result) {
      case Ok<TaskEntity>():
        taskList.add(result.value);
        taskEntity = result.value;
        return Result.ok(null);
      case Error<TaskEntity>():
        return Result.error(result.error);
    }
  }
}
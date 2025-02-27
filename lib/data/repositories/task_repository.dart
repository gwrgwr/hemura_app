import 'package:hemura/data/services/api_client.dart';
import 'package:hemura/data/services/sharedpreferences_services.dart';
import 'package:hemura/domain/session_entity.dart';
import 'package:hemura/domain/task_entity.dart';
import 'package:hemura/utils/result.dart';

class TaskRepository {
  final apiClient = ApiClient();

  Future<Result<List<TaskEntity>>> getTasks({required String sessionId}) async {
    int weekday = DateTime.now().weekday;
    Map<int, String> weekMap = {
      1: "monday",
      2: "tuesday",
      3: "wednesday",
      4: "thursday",
      5: "friday",
      6: "saturday",
      7: "sunday",
    };
    return await apiClient.getTasks(sessionId: sessionId, weekday: weekMap[weekday]!.toUpperCase());
  }

  Future<Result<TaskEntity>> createTask(String title, String description, String weekday, String time) async {
    final shared = SharedPreferencesService();
    final sessionEntity = await shared.getSessions();
    switch (sessionEntity) {
      case Ok<SessionEntity>():
        return await apiClient.createTask(sessionEntity.value.id, title, description, weekday, time);
      case Error<SessionEntity>():
        return Result.error(sessionEntity.error);
    }
  }

}
import 'dart:convert';

import 'package:hemura/domain/task_entity.dart';
import 'package:hemura/domain/user/user_create.dart';
import 'package:hemura/domain/user/user_entity.dart';
import 'package:hemura/utils/result.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/session_entity.dart';

class ApiClient {
  String url = "http://10.0.2.2:8080/api/v1";

  Future<Result<UserEntity>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$url/user/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );
      return Result.ok(UserEntity.fromMap(jsonDecode(response.body)));
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<UserCreate>> register(
      String name,
      String lastName,
      String email,
      String password,
      ) async {
    try {
      final response = await http.post(
        Uri.parse("$url/user"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"name": name, "lastName": lastName, "email": email, "password": password}),
      );
      print(jsonDecode(response.body));
      return Result.ok(UserCreate.fromMap(jsonDecode(response.body)));
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<SessionEntity>> getSessions({required String userId}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getStringList("user")![1];
      final response = await http.get(
        Uri.parse("$url/session/userId/$userId"),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return Result.ok(SessionEntity.fromMap(jsonDecode(response.body)));
      }
      if (response.statusCode == 404) {
        return Result.error(Exception("Sessão não encontrada"));
      }
      return Result.error(Exception("Erro ao buscar sessões"));
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<SessionEntity>> createSession({required String userId, required String name}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getStringList("user")![1];
      final response = await http.post(
        Uri.parse("$url/session/userId/$userId"),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
        body: name
      );
      if (response.statusCode == 201) {
        return Result.ok(SessionEntity.fromMap(jsonDecode(response.body)));
      }
      return Result.error(Exception("Erro ao criar sessão"));
    } on Exception catch(error) {
      return Result.error(error);
    }
  }

  Future<Result<SessionEntity>> joinSession({required String userId, required String code}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getStringList("user")![1];
      final response = await http.put(
          Uri.parse("$url/session/userId/$userId/$code"),
          headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return Result.ok(SessionEntity.fromMap(jsonDecode(response.body)));
      }
      return Result.error(Exception("Erro ao entrar sessão"));
    } on Exception catch(error) {
      return Result.error(error);
    }
  }

  Future<Result<List<TaskEntity>>> getTasks({required String sessionId, required String weekday}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getStringList("user")![1];
      final response = await http.get(
        Uri.parse("$url/task/sessionId/$sessionId/weekday/$weekday"),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        List<TaskEntity> tasks = [];
        for (var task in jsonDecode(response.body)) {
          tasks.add(TaskEntity.fromMap(task));
        }
        return Result.ok(tasks);
      }
      return Result.error(Exception("Erro ao buscar tarefas"));
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<TaskEntity>> createTask(String sessionId, String title, String description, String weekday, String time) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getStringList("user")![1];
      final response = await http.post(
        Uri.parse("$url/task/sessionId/$sessionId"),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
        body: jsonEncode({
          "title": title,
          "description": description,
          "weekDay": weekday,
          "time": time,
        }),
      );
      if (response.statusCode == 201) {
        return Result.ok(TaskEntity.fromMap(jsonDecode(response.body)));
      }
      return Result.error(Exception("Erro ao criar tarefa"));
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
import 'dart:convert';

import 'package:hemura/domain/session_entity.dart';
import 'package:hemura/domain/task_entity.dart';
import 'package:hemura/domain/user/user_response.dart';
import 'package:hemura/utils/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<Result<void>> saveUser(
    String id,
    String token,
    String email,
    String name,
    String lastName,
  ) async {
    final SharedPreferences prefs = await _getPrefs();
    await prefs.setStringList("user", [id, token, email, name, lastName]);
    return Result.ok(null);
  }

  Future<Result<void>> removeUser() async {
    try {
      final SharedPreferences prefs = await _getPrefs();
      await prefs.clear();
      await prefs.setBool("isLogged", false);
      return Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<SessionEntity>> getSessions() async {
    final SharedPreferences prefs = await _getPrefs();
    try {
      final List<String>? session = prefs.getStringList("session");
      if (session != null && session.length >= 5) {

        return Result.ok(
          SessionEntity(
            id: session[0],
            name: session[1],
            code: session[2],
            users: [],
            tasks: [],
          ),
        );
      }
      print(session);
      return Result.error(
        Exception("No session found or session data is incomplete"),
      );
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<void>> setSessions(SessionEntity sessionEntity) async {
    final SharedPreferences prefs = await _getPrefs();
    try {
      if (prefs.getStringList("session") != null) {
        await prefs.remove("session");
      }
      await prefs.setStringList("session", [
        sessionEntity.id,
        sessionEntity.name,
        sessionEntity.code,
        jsonEncode(sessionEntity.users.map((user) => user.toMap()).toList()),
        jsonEncode(sessionEntity.tasks.map((task) => task.toMap()).toList()),
      ]);
      return Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:hemura/data/services/sharedpreferences_services.dart';
import 'package:hemura/domain/session_entity.dart';
import 'package:hemura/data/repositories/session_repository.dart';
import 'package:hemura/utils/commander.dart';
import 'package:hemura/utils/result.dart';

class SessionViewModel {
  SessionViewModel() {
    get = Command0(_getSessions)..execute();
    addSession = Command1(_createSession);
    joinSession = Command1(_joinSession);
  }
  final repository = SessionRepository();
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  SessionEntity? sessionEntity;

  late final Command0 get;

  late final Command1<void, String> addSession;

  late final Command1<void, String> joinSession;

  Future<Result<void>> _getSessions() async {
    final result = await repository.getSessions();
    switch (result) {
      case Ok<SessionEntity>():
        sessionEntity = result.value;
      case Error<SessionEntity>():
        return Result.error(result.error);
    }
    return result;
  }

  Future<Result<void>> _createSession(String sessionName) async {
    final result = await repository.createSession(sessionName: sessionName);
    switch (result) {
      case Ok<SessionEntity>():
        sessionEntity = result.value;
      case Error<SessionEntity>():
        return Result.error(result.error);
    }
    return result;
  }

  Future<Result<void>> _joinSession(String code) async {
    final result = await repository.joinSession(code: code);
    switch (result) {
      case Ok<SessionEntity>():
        sessionEntity = result.value;
      case Error<SessionEntity>():
        return Result.error(result.error);
    }
    return result;
  }
}
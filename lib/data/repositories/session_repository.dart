import 'package:hemura/data/services/api_client.dart';
import 'package:hemura/data/services/sharedpreferences_services.dart';
import 'package:hemura/domain/session_entity.dart';
import 'package:hemura/utils/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionRepository {
  final apiClient = ApiClient();
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<Result<SessionEntity>> getSessions() async {
    final SharedPreferences prefs = await _getPrefs();
    String userId = prefs.getStringList("user")![0];
    Result<SessionEntity> result = await apiClient.getSessions(userId: userId);
    if (result is Ok<SessionEntity>) {
      await _sharedPreferencesService.setSessions(result.value);
    }
    return result;
  }

  Future<Result<SessionEntity>> createSession({required String sessionName}) async {
    final SharedPreferences prefs = await _getPrefs();
    String userId = prefs.getStringList("user")![0];

    Result<SessionEntity> result = await apiClient.createSession(userId: userId, name: sessionName);
    if (result is Ok<SessionEntity>) {
      await _sharedPreferencesService.setSessions(result.value);
    }
    return result;
  }

  Future<Result<SessionEntity>> joinSession({required String code}) async {
    final SharedPreferences prefs = await _getPrefs();
    String userId = prefs.getStringList("user")![0];
    Result<SessionEntity> result = await apiClient.joinSession(userId: userId, code: code);
    if (result is Ok<SessionEntity>) {
      await _sharedPreferencesService.setSessions(result.value);
    }
    return result;
  }
}
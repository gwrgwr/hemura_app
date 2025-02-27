import 'package:flutter/cupertino.dart';
import 'package:hemura/data/services/api_client.dart';
import 'package:hemura/data/services/sharedpreferences_services.dart';
import 'package:hemura/domain/user/user_entity.dart';
import 'package:hemura/ui/auth/user_provider.dart';
import 'package:hemura/utils/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final userService = ApiClient();


  Future<Result<UserEntity>> loginUser (String email, String password) async {
    try {
      final result = await userService.login(email, password);
      switch (result) {
        case Ok<UserEntity>():
          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          final userProvider = UserProvider();
          await userProvider.saveUser(result.value.id, result.value.token, result.value.email, result.value.name, result.value.lastName);
          await sharedPreferences.setBool("isLogged", true);
          return Result.ok(result.value);
        case Error<UserEntity>():
          return Result.error(result.error);
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<void>> logoutUser() async {
    final SharedPreferencesService sharedPreferencesService = SharedPreferencesService();
    return await sharedPreferencesService.removeUser();
  }
}
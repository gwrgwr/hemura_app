import 'package:flutter/cupertino.dart';
import 'package:hemura/domain/user/user_create.dart';
import 'package:hemura/domain/user/user_entity.dart';
import 'package:hemura/data/repositories/auth_repository.dart';
import 'package:hemura/utils/commander.dart';
import 'package:hemura/utils/result.dart';

class AuthViewModel {
  AuthViewModel() {
    loginUser = Command1(_loginUser);
    logoutUser = Command0(_logoutUser);
    registerUser = Command1(_registerUser);
  }
  final authRepository = AuthRepository();

  UserEntity? userEntity;
  UserCreate? userCreate;

  late final Command1<void, (String email, String password)> loginUser;

  late final Command0<void> logoutUser;

  late final Command1<void, (String name, String lastName, String email, String password)> registerUser;

  Future<Result<void>> _loginUser((String email, String password) credentials) async {
    final (email, password) = credentials;
    final result = await authRepository.loginUser(email, password);
    await Future.delayed(Duration(seconds: 2));
    switch (result) {
      case Ok<UserEntity>():
        userEntity = result.value;
      case Error<UserEntity>():
        return Result.error(result.error);
    }
    return result;
  }

  Future<Result<void>> _registerUser((String name, String lastName, String email, String password) credentials) async {
    final (name, lastName, email, password) = credentials;
    final result = await authRepository.register(name, lastName, email, password);
    switch (result) {
      case Ok<UserCreate>():
        userCreate = result.value;
      case Error<UserCreate>():
        return Result.error(result.error);
    }
    return result;
  }

  Future<Result<void>> _logoutUser() async {
    final result = await authRepository.logoutUser();
    switch (result) {
      case Ok<void>():
        userEntity = null;
      case Error<void>():
        return Result.error(result.error);
    }
    return result;
  }
}
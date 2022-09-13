import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projetofinal_mobile/src/components/config/safe_event.dart';
import 'package:projetofinal_mobile/src/core/constants/string_constants.dart';
import 'package:projetofinal_mobile/src/core/interfaces/safe_bloc.dart';
import 'package:projetofinal_mobile/src/core/util/safe_log_util.dart';
import 'package:projetofinal_mobile/src/domain/entity/login_entity.dart';
import 'package:projetofinal_mobile/src/domain/use_case/do_login_use_case.dart';
import 'package:projetofinal_mobile/src/domain/use_case/save_user_id_use_case.dart';
import 'package:projetofinal_mobile/src/domain/use_case/save_user_login_use_case.dart';
import 'package:projetofinal_mobile/src/domain/use_case/save_user_role_use_case.dart';
import 'package:projetofinal_mobile/src/domain/use_case/save_user_token_use_case.dart';

class LoginBloc extends SafeBloC {
  final DoLoginUseCase doLoginUseCase;
  final SaveUserLoginUseCase saveUserLoginUseCase;
  final SaveUserTokenUseCase saveUserTokenUseCase;
  final SaveUserRoleUseCase saveUserRoleUseCase;
  final SaveUserIdUseCase saveUserIdUseCase;

  late StreamController<bool> loginButtonController;
  late StreamController<SafeEvent<LoginEntity>> doLoginController;

  late TextEditingController userController;
  late TextEditingController passwordController;

  LoginBloc({
    required this.doLoginUseCase,
    required this.saveUserTokenUseCase,
    required this.saveUserLoginUseCase,
    required this.saveUserRoleUseCase,
    required this.saveUserIdUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    loginButtonController = StreamController.broadcast();
    doLoginController = StreamController.broadcast();
    userController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> doLogin() async {
    try {
      doLoginController.sink.add(SafeEvent.load());
      LoginEntity loginEntity = await doLoginUseCase.call(
        user: userController.text,
        password: passwordController.text,
      );
      if (loginEntity.accessToken?.isNotEmpty ?? false) {
        saveUserToken(loginEntity.accessToken);
        saveUserLogin(true);
      }
      doLoginController.sink.add(SafeEvent.done(loginEntity));
    } catch (e) {
      doLoginController.addError(e.toString());
      SafeLogUtil.instance.logError(e);
    }
  }

  void toogleLoginButton() {
    bool isUsernameOk = userController.text.trim().isNotEmpty;
    bool isPasswordOk = passwordController.text.trim().isNotEmpty;
    bool isButtonEnabled = (isUsernameOk && isPasswordOk);
    loginButtonController.sink.add(isButtonEnabled);
  }

  Future<void> saveUserLogin(bool value) async {
    try {
      await saveUserLoginUseCase.call(value);
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
  }

  Future<void> saveUserToken(String? value) async {
    try {
      await saveUserTokenUseCase.call(value ?? StringConstants.empty);
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
  }

  Future<void> saveUserRole(String? value) async {
    try {
      //await saveUserRoleUseCase.call(Pro);
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
  }

  @override
  Future<void> dispose() async {}
}

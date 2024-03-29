import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projetofinal_mobile/src/components/config/safe_event.dart';
import 'package:projetofinal_mobile/src/core/interfaces/safe_bloc.dart';
import 'package:projetofinal_mobile/src/domain/entity/register_entity.dart';

class RegisterBloc extends SafeBloC {
  // final DoRegisterUseCase doRegisterUseCase;

  late StreamController<bool> registerButtonController;
  late StreamController<SafeEvent<RegisterEntity>> doRegisterController;

  late TextEditingController nameController;
  late TextEditingController userController;
  late TextEditingController passwordController;

  RegisterBloc() {
    init();
  }

  @override
  Future<void> init() async {
    registerButtonController = StreamController.broadcast();
    doRegisterController = StreamController.broadcast();
    nameController = TextEditingController();
    userController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> doRegister() async {
    // try {
    //   doRegisterController.sink.add(SafeEvent.load());
    //   RegisterEntity registerEntity = await doRegisterUseCase(
    //     username: userController.text,
    //     name: nameController.text,
    //     password: passwordController.text,
    //   );

    //   doRegisterController.sink.add(SafeEvent.done(registerEntity));
    // } catch (e) {
    //   doRegisterController.addError(e.toString());
    //   SafeLogUtil.instance.logError(e);
    // }
  }

  void toogleRegisterButton() {
    bool isNameOk = nameController.text.trim().isNotEmpty;
    bool isUsernameOk = userController.text.trim().isNotEmpty;
    bool isPasswordOk = passwordController.text.trim().isNotEmpty;
    bool isButtonEnabled = (isUsernameOk && isPasswordOk && isNameOk);
    registerButtonController.sink.add(isButtonEnabled);
  }

  @override
  Future<void> dispose() async {}
}

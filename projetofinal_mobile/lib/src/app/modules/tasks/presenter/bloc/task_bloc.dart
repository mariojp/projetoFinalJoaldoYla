import 'dart:async';

import 'package:projetofinal_mobile/generated/l10n.dart';
import 'package:projetofinal_mobile/src/components/config/safe_event.dart';
import 'package:projetofinal_mobile/src/core/interfaces/safe_bloc.dart';
import 'package:projetofinal_mobile/src/core/util/safe_log_util.dart';
import 'package:projetofinal_mobile/src/domain/entity/answer_entity.dart';
import 'package:projetofinal_mobile/src/domain/entity/task_entity.dart';
import 'package:projetofinal_mobile/src/domain/use_case/do_register_admin_use_case.dart';
import 'package:projetofinal_mobile/src/domain/use_case/get_answers_use_Case.dart';
import 'package:projetofinal_mobile/src/domain/use_case/get_my_answers_use_Case.dart';
import 'package:projetofinal_mobile/src/domain/use_case/get_user_by_id_use_case.dart';
import 'package:projetofinal_mobile/src/domain/use_case/get_user_id_use_case.dart';
import 'package:projetofinal_mobile/src/domain/use_case/get_user_role_use_case.dart';
import 'package:projetofinal_mobile/src/service/config/error/error_exceptions.dart';
import 'package:projetofinal_mobile/src/service/config/interceptors/api_interceptors.dart';

class TaskBloc extends SafeBloC {
  final GetAnswersUseCase getAnswersUseCase;
  final GetUserRoleUseCase getUserRoleUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;
  final GetMyAnswersUseCase getMyAnswersUseCase;
  final GetUserIdUseCase getUserIdUseCase;

  late StreamController<SafeEvent<List<AnswerEntity>>> getAnswersController;
  late StreamController<SafeEvent<List<AnswerEntity>>> getMyAnswersController;
  bool isShowErrorDialog = true;
  RoleEnum userRole = RoleEnum.none;

  TaskBloc({
    required this.getAnswersUseCase,
    required this.getUserRoleUseCase,
    required this.getUserByIdUseCase,
    required this.getMyAnswersUseCase,
    required this.getUserIdUseCase,
  }) {
    init();
  }

  @override
  Future<void> init() async {
    getAnswersController = StreamController.broadcast();
    getMyAnswersController = StreamController.broadcast();
    await getUserId();
    await getUserRole();
  }

  Future<void> getUserRole() async {
    try {
      userRole = await getUserRoleUseCase.call();
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
  }

  Future<int?> getUserId() async {
    try {
      return await getUserIdUseCase.call();
    } catch (e) {
      SafeLogUtil.instance.logError(e);
    }
    return null;
  }

  Future<void> getUserById(AnswerEntity answer) async {
    try {
      final user = await getUserByIdUseCase.call(id: answer.userId);
      answer.user = user;
    } catch (e) {
      await ApiInterceptors.checkExpiration(e);
      SafeLogUtil.instance.logError(e);
    }
  }

  Future<void> getAnswers({required TaskEntity? task}) async {
    if (userRole == RoleEnum.student) return;

    try {
      getAnswersController.sink.add(SafeEvent.load());
      List<AnswerEntity> answers = await getAnswersUseCase(taskId: task?.id);
      for (final answer in answers) {
        await getUserById(answer);
      }
      getAnswersController.sink.add(SafeEvent.done(answers));
    } catch (e) {
      await ApiInterceptors.checkExpiration(e);
      if (e is NotFoundException) {
        isShowErrorDialog = false;
        getAnswersController.sink.addError(S.current.textNoAnswersFound);
      } else {
        SafeLogUtil.instance.logError(e);
        isShowErrorDialog = true;
        getAnswersController.sink.addError(e.toString());
      }
    }
  }

  Future<void> getMyAnswers(int? taskId) async {
    try {
      getMyAnswersController.sink.add(SafeEvent.load());
      List<AnswerEntity> answersResult =
          await getMyAnswersUseCase(userId: await getUserId());

      List<AnswerEntity> answers =
          answersResult.where((e) => e.task?.id == taskId).toList();

      if (answers.isEmpty) {
        isShowErrorDialog = false;
        getMyAnswersController.sink.addError(S.current.textNoAnswersFound);
      } else {
        isShowErrorDialog = true;
        getMyAnswersController.sink.add(SafeEvent.done(answers));
      }
    } catch (e) {
      await ApiInterceptors.checkExpiration(e);
      if (e is NotFoundException) {
        isShowErrorDialog = false;
        getMyAnswersController.sink.addError(S.current.textNoAnswersFound);
      } else {
        SafeLogUtil.instance.logError(e);
        isShowErrorDialog = true;
        getMyAnswersController.sink.addError(e.toString());
      }
    }
  }

  @override
  Future<void> dispose() async {}
}

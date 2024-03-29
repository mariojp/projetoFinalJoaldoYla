import 'package:flutter_modular/flutter_modular.dart';
import 'package:projetofinal_mobile/src/core/interfaces/safe_use_case.dart';
import 'package:projetofinal_mobile/src/domain/entity/register_entity.dart';
import 'package:projetofinal_mobile/src/service/remote/auth/auth_service.dart';
import 'package:projetofinal_mobile/src/service/remote/auth/auth_service_interface.dart';
import 'package:projetofinal_mobile/src/service/remote/auth/request/request_register.dart';

enum RoleEnum { admin, student, teacher, none }

extension RoleEnumExtension on RoleEnum {
  String get value {
    switch (this) {
      case RoleEnum.admin:
        return 'Admin';
      case RoleEnum.student:
        return 'Aluno';
      case RoleEnum.teacher:
        return 'Professor';
      case RoleEnum.none:
        return 'none';
    }
  }
}

class DoRegisterAdminUseCase extends SafeUseCase {
  late final IAuthService _service;

  DoRegisterAdminUseCase() {
    _service = Modular.get<AuthService>();
  }

  Future<RegisterEntity> call({
    required String name,
    required String username,
    required String password,
    bool isActive = true,
    RoleEnum profile = RoleEnum.student,
  }) async {
    final request = RequestRegisterAdmin(
      name: name.trim(),
      password: password.trim(),
      user: username,
      isActive: isActive,
      profileId: profile.index + 1,
    );

    final response = await _service.doRegisterAdmin(request);

    return RegisterEntity.toEntity(response);
  }
}

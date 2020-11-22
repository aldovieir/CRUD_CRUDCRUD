import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_proficiencia/app/shared/auth/auth_controller.dart';
import 'package:teste_proficiencia/app/shared/repositories/user_repository.dart';
import 'package:teste_proficiencia/app/shared/user_moldel/user_model.dart';

part 'edit_controller.g.dart';

@Injectable()
class EditController = _EditControllerBase with _$EditController;

abstract class _EditControllerBase with Store {
  AuthController auth = Modular.get();
  UserRepository userRepository = Modular.get();

  TextEditingController idController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @action
  Future<void> logout() async {
    auth.logout();
  }

  @action
  Future<bool> editUser() async {
    return userRepository.editUser(
        id: idController.text,
        user: UserModel(
          nome: nomeController.text,
          aniversario: dataController.text,
          email: emailController.text,
          imagem: imageController.text,
          senha: senhaController.text,
        ));
  }
}

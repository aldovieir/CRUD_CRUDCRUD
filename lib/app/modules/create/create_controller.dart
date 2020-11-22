import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_proficiencia/app/shared/repositories/user_repository.dart';
import 'package:teste_proficiencia/app/shared/user_moldel/user_model.dart';

part 'create_controller.g.dart';

@Injectable()
class CreateController = _CreateControllerBase with _$CreateController;

abstract class _CreateControllerBase with Store {
  UserRepository userRepository = Modular.get();
  TextEditingController nomeController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @action
  Future<bool> createUser() async {
    String md5senha = md5.convert(utf8.encode(senhaController.text)).toString();

    return userRepository.createUser(
        user: UserModel(
      nome: nomeController.text,
      aniversario: dataController.text,
      email: emailController.text,
      imagem: imageController.text,
      senha: md5senha,
    ));
  }

  @action
  Future<bool> emailExist() {
    return userRepository.emailExist(emailController.text);
  }
}

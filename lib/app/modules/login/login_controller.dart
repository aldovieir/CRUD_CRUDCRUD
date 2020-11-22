import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_proficiencia/app/shared/auth/auth_controller.dart';
import 'package:teste_proficiencia/app/shared/repositories/user_repository.dart';
import 'package:url_launcher/url_launcher.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  UserRepository userRepository = Modular.get();
  AuthController auth = Modular.get();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController renewPassController = TextEditingController();

  @observable
  bool isLoading = false;

  Future<bool> emailExist() {
    return userRepository.emailExist(emailController.text);
  }

  Future<bool> loginWithEmail(String _email, String _senha) {
    isLoading = true;
    return userRepository.loginWithEmail(_email, _senha).then((user) {
      if (user.id == null) {
        auth.isLogged = false;
        isLoading = false;
        return false;
      } else {
        auth.isLogged = true;
        isLoading = false;
        return true;
      }
    });
  }

  @action
  newPass() {
    userRepository.newPass(
        email: emailController.text, newpass: renewPassController.text);
  }

  @action
  launchURL() async {
    const url = 'https://crudcrud.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_proficiencia/app/shared/securestorage/storage.dart';
import 'package:teste_proficiencia/app/shared/user_moldel/user_model.dart';

part 'auth_controller.g.dart';

@Injectable()
class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  @observable
  String hash = "";

  @observable
  bool isLogged = false;

  @observable
  UserModel myUser = UserModel();

  @action
  Future<void> logout() async {
    Storage().deleteLogin().then((_) {
      myUser = UserModel();
      isLogged = false;
      Modular.to.pushReplacementNamed("/login");
    });
  }

  @action
  void setarPersistencia({
    @required UserModel user,
  }) {
    myUser = user;
    isLogged = true;
  }

  @action
  Future<UserModel> getStorageUserModel() async {
    String _id = await Storage().readString("id");
    String _email = await Storage().readString("email");
    String _nome = await Storage().readString("nome");
    String _imagem = await Storage().readString("imagem");
    String _aniversario = await Storage().readString("aniversario");
    return UserModel(
      id: _id,
      nome: _nome,
      imagem: _imagem,
      aniversario: _aniversario,
      email: _email,
    );
  }

  @action
  Future<void> whiteStorageUserModel(UserModel _user) async {
    Storage().writeString(key: "id", value: _user.id);
    Storage().writeString(key: "email", value: _user.email);
    Storage().writeString(key: "nome", value: _user.nome);
    Storage().writeString(key: "imagem", value: _user.imagem);
    Storage().writeString(key: "aniversario", value: _user.aniversario);
  }

  @action
  Future<void> getHash() async {
    hash = await Storage().readString("hash");
  }
}

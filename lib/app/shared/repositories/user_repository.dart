import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_proficiencia/app/shared/auth/auth_controller.dart';
import 'package:teste_proficiencia/app/shared/user_moldel/user_model.dart';

class UserRepository {
  AuthController auth = Modular.get();

  Future<List<UserModel>> getUsers() async {
    try {
      print(auth.hash);
      Response response =
          await Dio().get("https://crudcrud.com/api/${auth.hash}/usuarios");
      print(response);

      return UserModel.fromJsonList(response.data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> createUser({UserModel user}) async {
    try {
      Response response = await Dio().post(
          "https://crudcrud.com/api/${auth.hash}/usuarios",
          data: user.toJsonWithoutId());
      print(response);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteUser(String id) async {
    try {
      print(auth.hash);
      Response response = await Dio().delete(
        "https://crudcrud.com/api/${auth.hash}/usuarios/$id",
      );
      print(response);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editUser({String id, UserModel user}) async {
    try {
      await Dio().put(
        "https://crudcrud.com/api/${auth.hash}/usuarios/$id",
        data: user.toJsonWithoutId(),
      );
      getUsers();
      return true;
    } catch (e) {
      print(e);
      getUsers();
      return false;
    }
  }

  Future<UserModel> loginWithEmail(String _email, String _senha) async {
    String md5senha = md5.convert(utf8.encode(_senha)).toString();
    UserModel _myUser = UserModel();
    return getUsers().then((users) {
      users.forEach((user) {
        if (user.email == _email) {
          if (user.senha == md5senha) {
            //RECUPERAR HASH
            auth.getHash();
            //GRAVAR DADOS NO STORAGE
            auth.whiteStorageUserModel(user);
            //SETAR DADOS NO AUTH
            auth.setarPersistencia(user: user);
            _myUser = user;
          }
        }
      });
    }).then((_) => _myUser);
  }

  Future<bool> emailExist(String _email) async {
    bool exist = false;
    return getUsers().then((users) {
      users.forEach((user) {
        if (user.email == _email) {
          exist = true;
        }
      });
    }).then((_) => exist);
  }

  Future<void> newPass({String email, String newpass}) {
    String md5senha = md5.convert(utf8.encode(newpass)).toString();

    return getUsers().then((users) {
      users.forEach((user) {
        if (user.email == email) {
          editUser(
              id: user.id,
              user: UserModel(
                nome: user.nome,
                aniversario: user.aniversario,
                email: user.email,
                imagem: user.imagem,
                senha: md5senha,
              ));
        }
      });
    });
  }
}

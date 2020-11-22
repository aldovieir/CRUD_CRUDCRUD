// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $AuthController = BindInject(
  (i) => AuthController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthControllerBase, Store {
  final _$hashAtom = Atom(name: '_AuthControllerBase.hash');

  @override
  String get hash {
    _$hashAtom.reportRead();
    return super.hash;
  }

  @override
  set hash(String value) {
    _$hashAtom.reportWrite(value, super.hash, () {
      super.hash = value;
    });
  }

  final _$isLoggedAtom = Atom(name: '_AuthControllerBase.isLogged');

  @override
  bool get isLogged {
    _$isLoggedAtom.reportRead();
    return super.isLogged;
  }

  @override
  set isLogged(bool value) {
    _$isLoggedAtom.reportWrite(value, super.isLogged, () {
      super.isLogged = value;
    });
  }

  final _$myUserAtom = Atom(name: '_AuthControllerBase.myUser');

  @override
  UserModel get myUser {
    _$myUserAtom.reportRead();
    return super.myUser;
  }

  @override
  set myUser(UserModel value) {
    _$myUserAtom.reportWrite(value, super.myUser, () {
      super.myUser = value;
    });
  }

  final _$logoutAsyncAction = AsyncAction('_AuthControllerBase.logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$getStorageUserModelAsyncAction =
      AsyncAction('_AuthControllerBase.getStorageUserModel');

  @override
  Future<UserModel> getStorageUserModel() {
    return _$getStorageUserModelAsyncAction
        .run(() => super.getStorageUserModel());
  }

  final _$whiteStorageUserModelAsyncAction =
      AsyncAction('_AuthControllerBase.whiteStorageUserModel');

  @override
  Future<void> whiteStorageUserModel(UserModel _user) {
    return _$whiteStorageUserModelAsyncAction
        .run(() => super.whiteStorageUserModel(_user));
  }

  final _$getHashAsyncAction = AsyncAction('_AuthControllerBase.getHash');

  @override
  Future<void> getHash() {
    return _$getHashAsyncAction.run(() => super.getHash());
  }

  final _$_AuthControllerBaseActionController =
      ActionController(name: '_AuthControllerBase');

  @override
  void setarPersistencia({@required UserModel user}) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.setarPersistencia');
    try {
      return super.setarPersistencia(user: user);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hash: ${hash},
isLogged: ${isLogged},
myUser: ${myUser}
    ''';
  }
}

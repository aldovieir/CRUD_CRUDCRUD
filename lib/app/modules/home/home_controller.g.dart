// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(i<UserRepository>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_HomeControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$usersAtom = Atom(name: '_HomeControllerBase.users');

  @override
  ObservableList<UserModel> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableList<UserModel> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$getUsersAsyncAction = AsyncAction('_HomeControllerBase.getUsers');

  @override
  Future<void> getUsers() {
    return _$getUsersAsyncAction.run(() => super.getUsers());
  }

  final _$deleteUserAsyncAction = AsyncAction('_HomeControllerBase.deleteUser');

  @override
  Future<bool> deleteUser(String id) {
    return _$deleteUserAsyncAction.run(() => super.deleteUser(id));
  }

  final _$logoutAsyncAction = AsyncAction('_HomeControllerBase.logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
users: ${users}
    ''';
  }
}

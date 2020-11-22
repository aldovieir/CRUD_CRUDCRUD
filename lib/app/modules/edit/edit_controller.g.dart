// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $EditController = BindInject(
  (i) => EditController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditController on _EditControllerBase, Store {
  final _$logoutAsyncAction = AsyncAction('_EditControllerBase.logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$editUserAsyncAction = AsyncAction('_EditControllerBase.editUser');

  @override
  Future<bool> editUser() {
    return _$editUserAsyncAction.run(() => super.editUser());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}

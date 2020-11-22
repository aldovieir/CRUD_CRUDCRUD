import 'package:teste_proficiencia/app/modules/create/create_module.dart';
import 'package:teste_proficiencia/app/modules/edit/edit_module.dart';
import 'package:teste_proficiencia/app/modules/login/login_module.dart';
import 'package:teste_proficiencia/app/modules/splash/splash_module.dart';
import 'package:teste_proficiencia/app/shared/repositories/user_repository.dart';
import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:teste_proficiencia/app/app_widget.dart';
import 'package:teste_proficiencia/app/modules/home/home_module.dart';

import 'shared/auth/auth_controller.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $AppController,
        Bind((i) => AuthController()),
        Bind((i) => UserRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: SplashModule()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/login', module: LoginModule()),
        ModularRouter('/create', module: CreateModule()),
        ModularRouter('/edit', module: EditModule())
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}

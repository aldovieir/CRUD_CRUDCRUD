import 'create_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'create_page.dart';

class CreateModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $CreateController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => CreatePage()),
      ];

  static Inject get to => Inject<CreateModule>.of();
}

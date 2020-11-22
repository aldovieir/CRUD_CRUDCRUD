import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oktoast/oktoast.dart';
import 'package:teste_proficiencia/app/shared/auth/auth_controller.dart';
import 'home_controller.dart';
import 'package:teste_proficiencia/app/shared/widgets/renew_hash.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  AuthController auth = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (auth.myUser.imagem == null || auth.myUser.imagem == "")
                  ? CircleAvatar(backgroundColor: Colors.transparent)
                  : CircleAvatar(
                      backgroundImage: NetworkImage(auth.myUser.imagem),
                    ),
              SizedBox(width: 10),
              Text(auth.myUser.nome, style: TextStyle(fontSize: 12))
            ],
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                controller.logout();
              })
        ],
      ),
      body: Observer(
        builder: (BuildContext context) {
          if (controller.isLoading) {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (controller.users.isEmpty) {
            return Container(
              child: Center(
                child: Text("Não existe usuários!"),
              ),
            );
          }
          return Container(
            child: ListView.builder(
              itemCount: controller.users.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    child: ListTile(
                      isThreeLine: false,
                      leading: (controller.users[index].imagem == null ||
                              controller.users[index].imagem == "")
                          ? CircleAvatar(backgroundColor: Colors.transparent)
                          : CircleAvatar(
                              backgroundImage:
                                  NetworkImage(controller.users[index].imagem),
                            ),
                      title: Text(controller.users[index].nome,
                          style: TextStyle(fontSize: 20)),
                      subtitle: Text(
                          "Email: ${controller.users[index].email} \nData de Aniversário: ${controller.users[index].aniversario}",
                          style: TextStyle(fontSize: 10)),
                      trailing: Container(
                        width: 120,
                        child: Row(children: [
                          IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.grey,
                              onPressed: () {
                                Modular.to.pushNamed("/edit",
                                    arguments: controller.users[index]);
                              }),
                          IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.grey,
                              onPressed: () {
                                controller
                                    .deleteUser(controller.users[index].id)
                                    .then((success) {
                                  if (success == false) {
                                    showToast("Erro ao tentar deletar usuario!",
                                        backgroundColor: Colors.red[600]);
                                  }
                                });
                              })
                        ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RenewHash();
                });
          },
          label: Text("Hash"),
          icon: Icon(Icons.playlist_add)),
    );
  }
}

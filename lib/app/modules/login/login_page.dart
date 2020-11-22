import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oktoast/oktoast.dart';
import 'package:teste_proficiencia/app/shared/auth/auth_controller.dart';
import 'login_controller.dart';
import 'package:teste_proficiencia/app/shared/widgets/renew_hash.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller
  AuthController auth = Modular.get();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        padding: EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                        width: 150,
                        height: 150,
                        child: Image.asset("assets/logo.png")),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Email"),
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!email.contains("@")) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Senha"),
                      controller: controller.senhaController,
                      obscureText: true,
                      autocorrect: false,
                      validator: (pass) {
                        if (pass.isEmpty || pass.length < 6)
                          return 'Senha inválida';
                        return null;
                      },
                    ),
                    FlatButton(
                        onPressed: () {
                          renewPassword();
                        },
                        child: Text("Renovar Senha")),
                    SizedBox(height: 50),
                    Observer(builder: (_) {
                      return Container(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          onPressed: () {
                            if (formKey.currentState.validate())
                              controller
                                  .loginWithEmail(
                                      controller.emailController.text,
                                      controller.senhaController.text)
                                  .then((logged) {
                                if (logged) {
                                  Modular.to.pushReplacementNamed("/home");
                                } else {
                                  showToast("Login e/ou Senha inválidos!",
                                      backgroundColor: Colors.red[600]);
                                }
                              });
                          },
                          child: (controller.isLoading)
                              ? CircularProgressIndicator()
                              : Text("Login"),
                        ),
                      );
                    }),
                    Divider(),
                    RaisedButton(
                        color: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        onPressed: () {
                          Modular.to.pushNamed("/create");
                        },
                        child: Text(
                          "Criar Novo Usuario",
                          style: TextStyle(color: Colors.black),
                        )),
                    Divider(),
                    (auth.hash == null || auth.hash == "")
                        ? Center(
                            child: Column(
                            children: [
                              Text("Não há Hash cadastrada para o EndPoint!"),
                              Text(
                                  "Vamos ao Crud Crud obter uma nova? Clique aqui:"),
                              IconButton(
                                  icon: Icon(Icons.cloud_download,
                                      size: 40,
                                      color: Theme.of(context).accentColor),
                                  onPressed: () {
                                    controller.launchURL();
                                  })
                            ],
                          ))
                        : Observer(builder: (_) {
                            return Center(child: Text("Hash: ${auth.hash}"));
                          }),
                    Divider(),
                  ],
                ),
              ),
            ),
          ),
        ),
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

  Future<void> renewPassword() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: 300,
              height: 300,
              child: Card(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(22),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(child: Text("Digite uma nova senha:")),
                        TextFormField(
                          decoration: InputDecoration(labelText: "senha"),
                          controller: controller.renewPassController,
                          obscureText: true,
                        ),
                        Container(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            onPressed: () {
                              controller.emailExist().then((exist) {
                                if (exist) {
                                  controller.newPass();
                                  Modular.to.pop();
                                  showToast("Senha Alterada com Sucesso!",
                                      backgroundColor: Colors.red[600]);
                                } else {
                                  showToast("Email Não cadastrado!",
                                      backgroundColor: Colors.red[600]);
                                }
                              });
                            },
                            child: Text("Salvar"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

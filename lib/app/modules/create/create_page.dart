import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:teste_proficiencia/app/shared/auth/auth_controller.dart';
import 'create_controller.dart';

import 'package:teste_proficiencia/app/shared/widgets/renew_hash.dart';

class CreatePage extends StatefulWidget {
  final String title;
  const CreatePage({Key key, this.title = "Create"}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends ModularState<CreatePage, CreateController> {
  AuthController auth = Modular.get();
  DateTime selectedDate = new DateTime.now();
  var userPass;
  var userConfirmPass;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
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
                    validator: (pass) {
                      if (pass.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (pass.length < 6) return 'Senha muito curta';
                      return null;
                    },
                    onSaved: (pass) => userPass = pass,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Repita sua Senha"),
                    obscureText: true,
                    validator: (pass) {
                      if (pass.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (pass.length < 6) return 'Senha muito curta';
                      return null;
                    },
                    onSaved: (pass) => userConfirmPass = pass,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Nome Completo"),
                    controller: controller.nomeController,
                    validator: (name) {
                      if (name.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (name.trim().split(' ').length <= 1) {
                        return 'Preencha seu Nome completo';
                      }
                      return null;
                    },
                  ),
                  InkWell(
                    onTap: () => selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: "Data Aniversario"),
                        controller: controller.dataController,
                        validator: (data) {
                          if (data.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                      decoration: InputDecoration(labelText: "Link Foto"),
                      controller: controller.imageController),
                  SizedBox(height: 50),
                  Container(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          if (userPass != userConfirmPass) {
                            return showToast(
                              'Senhas não coincidem!',
                              backgroundColor: Colors.red,
                            );
                          }
                          return controller.emailExist().then((isExist) {
                            if (!isExist) {
                              controller.createUser().then((isCreated) {
                                if (isCreated) {
                                  Modular.to.pop();
                                  showToast("Usuário Criado com Sucesso!");
                                } else {
                                  Modular.to.pop();
                                  showToast("Erro ao criar usuário!",
                                      backgroundColor: Colors.red[600]);
                                }
                              });
                            } else {
                              Modular.to.pop();
                              showToast("Email Já Existe",
                                  backgroundColor: Colors.red[600]);
                            }
                          });
                        }
                      },
                      child: Text("Criar Novo"),
                    ),
                  )
                ],
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

  Future<Null> selectDate(BuildContext context) async {
    double height = MediaQuery.of(context).size.height;
    DateTime today = DateTime.now().toLocal();

    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: (height / 2.5),
            child: Column(
              children: [
                Flexible(
                  flex: 5,
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.grey[200],
                    mode: CupertinoDatePickerMode.date,
                    minimumDate: DateTime(today.year - 100),
                    maximumDate: today,
                    initialDateTime: (selectedDate == null)
                        ? DateTime(today.year - 20)
                        : selectedDate,
                    onDateTimeChanged: (dateTime) {
                      setState(() {
                        selectedDate = dateTime;
                        controller.dataController.text =
                            DateFormat("dd/MM/yyyy").format(selectedDate);
                      });
                    },
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: FlatButton(
                      onPressed: () {
                        Modular.to.pop();
                      },
                      child: Text("Ok")),
                )
              ],
            ),
          );
        });
  }
}

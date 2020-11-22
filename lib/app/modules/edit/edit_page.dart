import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:teste_proficiencia/app/modules/home/home_controller.dart';
import 'package:teste_proficiencia/app/shared/user_moldel/user_model.dart';
import 'edit_controller.dart';
import 'package:teste_proficiencia/app/shared/widgets/renew_hash.dart';

class EditPage extends StatefulWidget {
  final UserModel user;

  const EditPage({Key key, @required this.user}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  DateTime selectedDate = new DateTime.now();
  EditController controller = Modular.get();
  var userPass;
  var userConfirmPass;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  HomeController homeController = Modular.get();
  @override
  Widget build(BuildContext context) {
    controller.idController.text = widget.user.id ?? "";
    controller.emailController.text = widget.user.email ?? "";
    controller.nomeController.text = widget.user.nome ?? "";
    controller.dataController.text = widget.user.aniversario ?? "";
    controller.imageController.text = widget.user.imagem ?? "";
    controller.senhaController.text = widget.user.senha;

    return Scaffold(
      appBar: AppBar(
        title: Text('Editando Usuário'),
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
                  /*    TextFormField(
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
                  ), */
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
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          if (userPass != userConfirmPass) {
                            return showToast(
                              'Senhas não coincidem!',
                              backgroundColor: Colors.red,
                            );
                          }
                          return controller.editUser().then((isEditd) {
                            if (isEditd) {
                              homeController.getUsers();
                              Modular.to.pop();
                              showToast("Usuário Atualizado com Sucesso!");
                            } else {
                              Modular.to.pop();
                              showToast("Erro ao atualizar usuário!",
                                  backgroundColor: Colors.red[600]);
                            }
                          });
                        }
                      },
                      child: Text("Salvar Alterações ?"),
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

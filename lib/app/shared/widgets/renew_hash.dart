import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_proficiencia/app/shared/auth/auth_controller.dart';
import 'package:teste_proficiencia/app/shared/securestorage/storage.dart';

// ignore: must_be_immutable
class RenewHash extends StatelessWidget {
  TextEditingController hashController = TextEditingController();
  AuthController auth = Modular.get();

  @override
  Widget build(BuildContext context) {
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
                  Center(child: Text("Digite um novo Hash")),
                  TextFormField(
                    decoration: InputDecoration(labelText: "hash"),
                    controller: hashController,
                  ),
                  Container(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      onPressed: () {
                        auth.hash = hashController.text;
                        Storage().writeString(key: "hash", value: auth.hash);
                        Modular.to.pop();
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
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:todo/components/column_center.dart';
import 'package:todo/components/form_button.dart';
import 'package:todo/components/text_form_input.dart';
import 'package:todo/functions/generate_inputs.dart';
import 'package:todo/functions/validate.dart';

import '../home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void redirect() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  void showProcessing() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Processando...')));
  }

  void hideProcessing() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Criar Conta")),
        body: ColumnCenter(
          childrens: [
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text(
                "Bem-Vindo",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      child: TextFormInput(
                        label: 'Email',
                        controller: emailController,
                        validator: (value) => Validate.email(value),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      child: TextFormInput(
                          label: 'Username',
                          controller: usernameController,
                          validator: (value) => Validate.username(value)),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: TextFormInput(
                                label: 'Senha',
                                controller: passwordController,
                                validator: (value) => Validate.password(value),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                                child: TextFormInput(
                                    label: 'Confirmar Senha',
                                    controller: passwordConfirmController,
                                    validator: (value) =>
                                        Validate.correctPassword(
                                            value, passwordController.text))),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        child: FormButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              showProcessing();

                              Response res = await http.post(
                                  Uri.http('localhost:5050', '/api/v1/signup'),
                                  body: jsonEncode({
                                    'email': emailController.text,
                                    'password': passwordController.text,
                                    'username': usernameController.text,
                                  }),
                                  headers: {
                                    'Content-Type': 'application/json'
                                  });

                              hideProcessing();

                              // + 201 - Created
                              if (res.statusCode == 201) {
                                return redirect();
                              }

                              // + 409 - Conflict
                              if (res.statusCode == 409) {
                                Fluttertoast.showToast(
                                    msg: res.body
                                        .split(':')[2]
                                        .replaceFirst("}", ""),
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                    webPosition: "center");
                                return;
                              }

                              Fluttertoast.showToast(
                                msg: "Alguma coisa deu errada",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            },
                            body: const Text("Criar")))
                  ],
                )),
          ],
        ));
  }
}

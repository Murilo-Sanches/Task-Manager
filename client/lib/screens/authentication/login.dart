import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:todo/components/column_center.dart';
import 'package:todo/components/form_button.dart';
import 'package:todo/components/text_form_input.dart';
import 'package:todo/functions/validate.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/authentication/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var s = '';

  void state(String input) {
    setState(() {
      s = input;
    });
  }

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
        body: ColumnCenter(childrens: [
      const Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: Text(
          "Bem-Vindo",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      // Text(s),
      Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: TextFormInput(
                  label: 'Email',
                  controller: emailController,
                  validator: (value) => Validate.email(value),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: TextFormInput(
                    label: "Senha",
                    controller: passwordController,
                    // validator: (value) => Validate.password(value)),
                    validator: (value) => Validate.password(value)),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                  child: FormButton(
                    onPressed: () async {
                      try {
                        if (!_formKey.currentState!.validate()) {
                          return state("input");
                        }

                        state(emailController.text);

                        showProcessing();

                        Response res = await http
                            .post(Uri.http('localhost:5050', '/api/v1/login'),
                                body: jsonEncode({
                                  'email': emailController.text,
                                  'password': passwordController.text,
                                }),
                                headers: {'content-type': 'application/json'});

                        hideProcessing();

                        if (res.statusCode == 403) {
                          Fluttertoast.showToast(
                            msg: res.body.split(':')[2].replaceFirst("}", ""),
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }

                        if (res.statusCode == 200) {
                          return redirect();
                        }

                        Fluttertoast.showToast(
                          msg: "Alguma coisa deu errada",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } catch (e) {
                        Fluttertoast.showToast(
                          msg: "Alguma coisa deu errada",
                          toastLength: Toast.LENGTH_SHORT,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    body: const Text('Logar'),
                  )),
            ],
          )),
      Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
          child: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            },
            child: const Text("Criar Conta"),
          )),
    ]));
  }
}

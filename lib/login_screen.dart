import 'dart:async';

import 'package:djossi/my_classes.dart';
import 'package:djossi/my_constants.dart';
import 'package:djossi/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base.dart';
import 'my_functions.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPasswordVisible = true;
  var telOrEmailController = TextEditingController();
  var passwordController = TextEditingController();
  dynamic telOrEmailValidationMsg = "";
  dynamic passwordValidationMsg;

  late Worker currentWorker;
  final _formKey = GlobalKey<FormState>();

  Future<bool> isAllOk(telOrEmail, password) async {
    if (await isTelOrEmailOk(telOrEmail) &&
        await isPasswordOk(telOrEmail, password)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isPasswordOk(telOrEmail, password) async {
    if (await isTelOrEmailOk(telOrEmail)) {
      if (currentWorker.hashedPassword == password) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> isTelOrEmailOk(telOrEmail) async => getWorkerBy(telOrEmail).then(
        (value) {
          setState(
            () {
              currentWorker = value;
            },
          );
          if (value.firstname != "") {
            return true;
          }

          return false;
        },
      ).onError(
        (error, stackTrace) {
          return false;
        },
      );

  Future<void> logUser(telOrEmail, password, model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAllOk(telOrEmail, password).then(
      (value) {
        if (value) {
          prefs.setInt("currentWorkerId", currentWorker.id);

          Fluttertoast.showToast(
            msg: "Vous etes connecté avec succes",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Base(),
            ),
          );
        }
      },
    );
  }

  void telOrEmailValidation() async {
    if (await isTelOrEmailOk(telOrEmailController.value.text)) {
      setState(() {
        telOrEmailValidationMsg = null;
        passwordValidationMsg = "Mot de passe incorrect";
      });
    } else {
      setState(() {
        telOrEmailValidationMsg = "cet identifiant n'existe pas";
      });
    }
  }

  void passwordValidation() async {
    if (await isTelOrEmailOk(telOrEmailController.value.text)) {
      if (await isPasswordOk(
          telOrEmailController.value.text, passwordController.value.text)) {
        setState(() {
          passwordValidationMsg = null;
        });
      } else {
        setState(() {
          passwordValidationMsg = "Mot de passe incorrect";
        });
      }
    } else {
      setState(() {
        passwordValidationMsg = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GlobalStateModel>(
      create: (_) => GlobalStateModel(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: myPrimaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Se connecter",
                  style: getFontStyleFromMediaSize(
                    context,
                    384,
                    640,
                    TextStyle(
                      fontSize: myTitleFontSize,
                    ),
                    TextStyle(
                      fontSize: myTitleFontSize,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          TextFormField(
                            controller: telOrEmailController,
                            onChanged: (value) {
                              telOrEmailValidation();
                            },
                            validator: (value) => telOrEmailValidationMsg,
                            cursorColor: myPrimaryColor,
                            decoration: InputDecoration(
                              hintText: "Numero de telephone ou adresse e-mail",
                              focusColor: myPrimaryColor,
                              hintStyle: getFontStyleFromMediaSize(
                                context,
                                384,
                                640,
                                TextStyle(fontSize: myTextSmallFontSize2),
                                TextStyle(fontSize: myTextMediumFontSize),
                              ),
                            ),
                          ),
                          Wrap(
                            alignment: WrapAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 20),
                                child: Wrap(
                                  alignment: WrapAlignment.end,
                                  children: [
                                    Text(
                                      "Entrez le numero mobile sans le '+' ou le 00 ou le code du pays.",
                                      style: getFontStyleFromMediaSize(
                                        context,
                                        384,
                                        640,
                                        TextStyle(
                                          fontSize: myTextSmallFontSize,
                                        ),
                                        TextStyle(
                                          fontSize: myTextSmallFontSize,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) => passwordValidationMsg,
                            onChanged: (value) {
                              passwordValidation();
                            },
                            obscureText: isPasswordVisible,
                            cursorColor: myPrimaryColor,
                            decoration: InputDecoration(
                              hintText: "Mot de passe",
                              focusColor: myPrimaryColor,
                              hintStyle: getFontStyleFromMediaSize(
                                context,
                                384,
                                640,
                                TextStyle(fontSize: myTextSmallFontSize2),
                                TextStyle(fontSize: myTextMediumFontSize),
                              ),
                              suffixIcon: IconButton(
                                icon: isPasswordVisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                onPressed: () {
                                  setState(
                                    () {
                                      isPasswordVisible = !isPasswordVisible;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 20),
                                child: Text(
                                  "Vous avez oubliez votre mot de passe?",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          Consumer<GlobalStateModel>(
                            builder: (context, model, child) => ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  isAllOk(telOrEmailController.value.text,
                                          passwordController.value.text)
                                      .then(
                                    (value) {
                                      if (value) {
                                        model.currentWorker = currentWorker;

                                        Fluttertoast.showToast(
                                          msg: "Vous etes connecté avec succes",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Base(),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(myPrimaryColor),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "s'identifier",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "vous n'avez pas de compte?",
                                style: getFontStyleFromMediaSize(
                                  context,
                                  384,
                                  640,
                                  TextStyle(fontSize: myTextSmallFontSize),
                                  TextStyle(fontSize: myTextMediumFontSize),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Registrer()),
                                  );
                                },
                                child: Text(
                                  "créez en maintenant!",
                                  style: getFontStyleFromMediaSize(
                                    context,
                                    384,
                                    640,
                                    TextStyle(
                                        color: myPrimaryColor,
                                        fontSize: myTextSmallFontSize),
                                    TextStyle(
                                        color: myPrimaryColor,
                                        fontSize: myTextMediumFontSize),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:djossi/my_constants.dart';
import 'package:djossi/register_screen.dart';
import 'package:flutter/material.dart';

import 'base.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: MediaQuery.of(context).size.height * (1 / 6),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * (1 / 20)),
              child: Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Text(
                        "Se connecter",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.clear,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                    cursorColor: myPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Numero de telephone ou adresse e-mail",
                      focusColor: myPrimaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * (1 / 20)),
                    child: const TextButton(
                      onPressed: null,
                      child: Text(
                        "Entrez le numero mobile sans le '+' ou le 00 ou le code du pays.",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: isPasswordVisible,
                    cursorColor: myPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Mot de passe",
                      focusColor: myPrimaryColor,
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
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * (1 / 20)),
                    child: const TextButton(
                      onPressed: null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Vous avez oubliez votre mot de passe?",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * (1 / 20)),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Base()),
                        );
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
                    children: [
                      const Text(
                        "vous n'avez pas de compte?",
                        style: TextStyle(fontSize: 11),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Registrer()),
                          );
                        },
                        child: const Text(
                          "créez en maintenant!",
                          style: TextStyle(
                            color: Colors.blue,
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
      ),
    );
  }
}

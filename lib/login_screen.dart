import 'package:djossi/my_constants.dart';
import 'package:djossi/register_screen.dart';
import 'package:flutter/material.dart';

import 'base.dart';
import 'my_functions.dart';

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
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: MediaQuery.of(context).size.height * (1 / 6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Se connecter",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
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
                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 20),
                    child: Text(
                      "Entrez le numero mobile sans le '+' ou le 00 ou le code du pays.",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  TextFormField(
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Base()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(myPrimaryColor),
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
      ),
    );
  }
}

import 'package:djossi/my_constants.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'my_functions.dart';

class Registrer extends StatefulWidget {
  const Registrer({super.key});

  @override
  State<Registrer> createState() => _RegistrerState();
}

class _RegistrerState extends State<Registrer> {
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
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              "S' enregistrer",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            cursorColor: myPrimaryColor,
                            decoration: InputDecoration(
                              hintText: "Prénom",
                              hintStyle: getFontStyleFromMediaSize(
                                context,
                                384,
                                640,
                                TextStyle(fontSize: myTextSmallFontSize2),
                                TextStyle(fontSize: myTextMediumFontSize),
                              ),
                              focusColor: myPrimaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            cursorColor: myPrimaryColor,
                            decoration: InputDecoration(
                              hintText: "Nom",
                              hintStyle: getFontStyleFromMediaSize(
                                context,
                                384,
                                640,
                                TextStyle(fontSize: myTextSmallFontSize2),
                                TextStyle(fontSize: myTextMediumFontSize),
                              ),
                              focusColor: myPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TextFormField(
                      cursorColor: myPrimaryColor,
                      decoration: InputDecoration(
                        hintText: "Adresse e-mail",
                        hintStyle: getFontStyleFromMediaSize(
                          context,
                          384,
                          640,
                          TextStyle(fontSize: myTextSmallFontSize2),
                          TextStyle(fontSize: myTextMediumFontSize),
                        ),
                        focusColor: myPrimaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      obscureText: isPasswordVisible,
                      cursorColor: myPrimaryColor,
                      decoration: InputDecoration(
                        hintText: "Mot de passe",
                        hintStyle: getFontStyleFromMediaSize(
                          context,
                          384,
                          640,
                          TextStyle(fontSize: myTextSmallFontSize2),
                          TextStyle(fontSize: myTextMediumFontSize),
                        ),
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
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "En cliquant sur le boutton enregistrer, vous accepté les conditions d'utilisation suivantes Mentions Legales.",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(myPrimaryColor),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Enregistrer",
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
                        "vous avez deja un compte?",
                        style: TextStyle(fontSize: 11),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: const Text(
                          "Connectez vous!",
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

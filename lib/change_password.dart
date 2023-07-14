import 'package:djossi/my_classes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_constants.dart';
import 'my_functions.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  var firstPassword = TextEditingController();
  var secondPassword = TextEditingController();
  dynamic globalStateProvider;

  @override
  void didChangeDependencies() {
    globalStateProvider = Provider.of<GlobalStateModel>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Modification du mot de passe",
                            style: getFontStyleFromMediaSize(
                              context,
                              384,
                              640,
                              TextStyle(
                                color: Colors.white,
                                fontSize: myTextSmallFontSize,
                              ),
                              TextStyle(
                                fontSize: myTextBigFontSize,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Nouveau mot de passe: ",
                                    style: getFontStyleFromMediaSize(
                                      context,
                                      384,
                                      640,
                                      TextStyle(
                                        color: Colors.white,
                                        fontSize: myTextSmallFontSize,
                                      ),
                                      TextStyle(
                                        fontSize: myTextMediumFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: firstPassword,
                                      validator: (value) {
                                        if (value == "") {
                                          return ("le mot de passe ne peut pas etre vide");
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "confirmer le mot de passe: ",
                                    style: getFontStyleFromMediaSize(
                                      context,
                                      384,
                                      640,
                                      TextStyle(
                                        color: Colors.white,
                                        fontSize: myTextSmallFontSize,
                                      ),
                                      TextStyle(
                                        fontSize: myTextMediumFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: secondPassword,
                                      validator: (value) {
                                        if (value != firstPassword.value.text) {
                                          return ("le mot de passe ne correspond pas");
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        saveInformations(context, {
                                          'id': globalStateProvider
                                              .currentWorker.id
                                              .toString(),
                                          'hashed_password':
                                              secondPassword.value.text,
                                        }).then((value) {
                                          showToast(
                                              "votre mot de passe a ete modifié avec succes");
                                          Navigator.pop(context);
                                        }).onError((error, stackTrace) {
                                          showToast("une erreur est survenue");
                                          Navigator.pop(context);
                                        });
                                      }
                                    },
                                    child: const Text("changer"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

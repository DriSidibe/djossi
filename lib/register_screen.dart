import 'dart:io';

import 'package:djossi/my_constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'my_classes.dart';
import 'my_functions.dart';

class Registrer extends StatefulWidget {
  const Registrer({super.key});

  @override
  State<Registrer> createState() => _RegistrerState();
}

class _RegistrerState extends State<Registrer> {
  bool isPasswordVisible = true;
  List<String> jobsList = [
    "--selectionnez un métier--",
    "Plombier",
    "Menuisier"
  ];
  final photoNameFieldController = TextEditingController();
  File? galleryFile;
  final picker = ImagePicker();

  @override
  void dispose() {
    photoNameFieldController.dispose();
    super.dispose();
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  Future<bool> isEmailAlreadyExist(email) async {
    return isEmailOrTelAlreadyExist(email);
  }

  Future<bool> isTelAlreadyExist(tel) {
    return isEmailOrTelAlreadyExist(tel);
  }

  var firstnameTextFieldController = TextEditingController();
  var lastnameTextFieldController = TextEditingController();
  var emailTextFieldController = TextEditingController();
  var telTextFieldController = TextEditingController();
  var jobTextFieldValue = "";
  var passwordTextFieldController = TextEditingController();
  var photoTextFieldController = TextEditingController();
  var hashedPassword = "";
  var firstPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: myPrimaryColor,
            onPressed: () {
              context.goNamed("home");
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
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "S' enregistrer",
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: lastnameTextFieldController,
                                    validator: (value) {
                                      // ignore: unrelated_type_equality_checks
                                      if (value == null || value.isEmpty) {
                                        return 'Ce champs doit etre renseigné';
                                      }
                                      return null;
                                    },
                                    cursorColor: myPrimaryColor,
                                    decoration: InputDecoration(
                                      hintText: "Prénom",
                                      hintStyle: getFontStyleFromMediaSize(
                                        context,
                                        384,
                                        640,
                                        TextStyle(
                                            fontSize: myTextSmallFontSize2),
                                        TextStyle(
                                            fontSize: myTextMediumFontSize),
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
                                    controller: firstnameTextFieldController,
                                    validator: (value) {
                                      // ignore: unrelated_type_equality_checks
                                      if (value == null || value.isEmpty) {
                                        return 'Ce champs doit etre renseigné';
                                      }
                                      return null;
                                    },
                                    cursorColor: myPrimaryColor,
                                    decoration: InputDecoration(
                                      hintText: "Nom",
                                      hintStyle: getFontStyleFromMediaSize(
                                        context,
                                        384,
                                        640,
                                        TextStyle(
                                            fontSize: myTextSmallFontSize2),
                                        TextStyle(
                                            fontSize: myTextMediumFontSize),
                                      ),
                                      focusColor: myPrimaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              controller: emailTextFieldController,
                              validator: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (value == null || value.isEmpty) {
                                  return 'Ce champs doit etre renseigné';
                                }
                                if (!EmailValidator.validate(value)) {
                                  return 'Format d\'email incorrect';
                                }

                                return null;
                              },
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
                            padding: const EdgeInsets.only(bottom: 8),
                            child: IntlPhoneField(
                              controller: telTextFieldController,
                              validator: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (value == null) {
                                  return 'Ce champs doit etre renseigné';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Numero de telephone',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                              initialCountryCode: 'CI',
                              onChanged: (phone) {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: CustomSingleSelectField<String>(
                              validator: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (value == null ||
                                    value.isEmpty ||
                                    jobTextFieldValue ==
                                        "--selectionnez un métier--") {
                                  return 'Ce champs doit etre renseigné';
                                }
                                return null;
                              },
                              selectedItemColor: myPrimaryColor,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: jobTextFieldValue ==
                                          "--selectionnez un métier--"
                                      ? Colors.red
                                      : Colors.black,
                                )),
                                suffix: const Icon(Icons.unfold_more),
                              ),
                              items: jobsList,
                              title: "Metier",
                              initialValue: jobsList[0],
                              onSelectionDone: (value) {
                                setState(() {
                                  jobTextFieldValue = value.toString();
                                });
                              },
                              itemAsString: (item) => item,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              controller: firstPassword,
                              validator: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (value == null || value.isEmpty) {
                                  return 'Ce champs doit etre renseigné';
                                }
                                return null;
                              },
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              controller: passwordTextFieldController,
                              validator: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (value == null ||
                                    value.isEmpty ||
                                    // ignore: unrelated_type_equality_checks
                                    passwordTextFieldController.value !=
                                        firstPassword.value) {
                                  return 'Les mots de passe ne correspondent pas';
                                }
                                return null;
                              },
                              obscureText: isPasswordVisible,
                              cursorColor: myPrimaryColor,
                              decoration: InputDecoration(
                                hintText: "Confirmer le mot de passe",
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Text("Mettez une photo :"),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: photoNameFieldController,
                                    enabled: false,
                                    cursorColor: myPrimaryColor,
                                    decoration: InputDecoration(
                                      hintText: "Photo",
                                      hintStyle: getFontStyleFromMediaSize(
                                        context,
                                        384,
                                        640,
                                        TextStyle(
                                            fontSize: myTextSmallFontSize2),
                                        TextStyle(
                                            fontSize: myTextMediumFontSize),
                                      ),
                                      focusColor: myPrimaryColor,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                  ),
                                  onPressed: () {
                                    _showPicker(context: context);
                                    if (galleryFile != null) {
                                      photoNameFieldController.text =
                                          galleryFile!.path;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "En cliquant sur le boutton enregistrer, vous accepté les conditions d'utilisation suivantes Mentions Legales.",
                              style: getFontStyleFromMediaSize(
                                context,
                                384,
                                640,
                                TextStyle(
                                  fontSize: myTextSmallFontSize,
                                ),
                                TextStyle(
                                  fontSize: myTextSmallFontSize2,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var client = http.Client();
                                try {
                                  if (!await isEmailAlreadyExist(
                                          emailTextFieldController
                                              .value.text) &&
                                      !await isTelAlreadyExist(
                                          telTextFieldController.value.text)) {
                                    var response = await client.get(
                                      Uri.http(
                                        '192.168.1.191:8000',
                                        'workers/add',
                                        {
                                          'firstname':
                                              firstnameTextFieldController
                                                  .value.text
                                                  .toString(),
                                          'lastname':
                                              lastnameTextFieldController
                                                  .value.text
                                                  .toString(),
                                          'job': jobTextFieldValue.toString(),
                                          'hashed_password':
                                              passwordTextFieldController
                                                  .value.text
                                                  .toString(),
                                          'tel': telTextFieldController
                                              .value.text
                                              .toString(),
                                          'profil_photo':
                                              "photoNameFieldController.value",
                                          'email': emailTextFieldController
                                              .value.text
                                              .toString()
                                              .toLowerCase(),
                                        },
                                      ),
                                    );
                                    if (response.body != "0") {
                                      // ignore: use_build_context_synchronously
                                      Fluttertoast.showToast(
                                          msg: "Une erreur est survenue",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Enrégistré avec succes",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      await (await SharedPreferences
                                              .getInstance())
                                          .setBool('connected', true)
                                          .then(
                                        (value) async {
                                          dynamic id;
                                          getWorkerBy(emailTextFieldController
                                                  .value.text)
                                              .then(
                                            (value) async {
                                              id = value.id;

                                              replaceExistingCurrentWorker(
                                                      Worker(
                                                        id,
                                                        firstnameTextFieldController
                                                            .value.text,
                                                        lastnameTextFieldController
                                                            .value.text,
                                                        emailTextFieldController
                                                            .value.text,
                                                        jobTextFieldValue,
                                                        telTextFieldController
                                                            .value.text,
                                                        photoNameFieldController
                                                            .text,
                                                        hashedPassword,
                                                      ),
                                                      "currentUser")
                                                  .then((value) {
                                                context.goNamed("base");
                                              }).onError((error, stackTrace) =>
                                                      exit(1));
                                            },
                                          ).onError(
                                            (error, stackTrace) {
                                              exit(1);
                                            },
                                          );
                                        },
                                      ).onError(
                                        (error, stackTrace) => exit(1),
                                      );
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Le numéro de téléphone ou l'email existe deja dans la base de donnés",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                } on Exception catch (_) {
                                  if (_.toString() == "Connection failed") {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Vous n'ets pas connectz à internet",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                } finally {
                                  client.close();
                                }
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
                              Text(
                                "vous avez deja un compte?",
                                style: getFontStyleFromMediaSize(
                                  context,
                                  384,
                                  640,
                                  TextStyle(
                                    fontSize: myTextSmallFontSize,
                                  ),
                                  TextStyle(
                                    fontSize: myTextMediumFontSize,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.goNamed("login");
                                },
                                child: Text(
                                  "Connectez vous!",
                                  style: getFontStyleFromMediaSize(
                                    context,
                                    384,
                                    640,
                                    TextStyle(
                                      fontSize: myTextSmallFontSize,
                                      color: myPrimaryColor,
                                    ),
                                    TextStyle(
                                      fontSize: myTextMediumFontSize,
                                      color: myPrimaryColor,
                                    ),
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
      getWifiUnavailableWidget(context),
    ]);
  }
}

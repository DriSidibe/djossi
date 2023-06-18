import 'dart:io';

import 'package:djossi/my_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'login_screen.dart';
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
                          padding: const EdgeInsets.only(bottom: 20),
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
                          padding: const EdgeInsets.only(bottom: 8),
                          child: IntlPhoneField(
                            decoration: const InputDecoration(
                              labelText: 'Numero de telephone',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            initialCountryCode: 'IN',
                            onChanged: (phone) {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: CustomSingleSelectField<String>(
                            selectedItemColor: myPrimaryColor,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                              )),
                              suffix: Icon(Icons.unfold_more),
                            ),
                            items: jobsList,
                            title: "Metier",
                            initialValue: jobsList[0],
                            onSelectionDone: (value) {},
                            itemAsString: (item) => item,
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
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
                          child: TextFormField(
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
                                      TextStyle(fontSize: myTextSmallFontSize2),
                                      TextStyle(fontSize: myTextMediumFontSize),
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
                          onPressed: null,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                );
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
    );
  }
}

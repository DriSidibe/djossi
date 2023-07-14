import 'dart:io';

import 'package:djossi/my_classes.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_selector/widget/flutter_single_select.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import 'my_constants.dart';
import 'my_functions.dart';

class WorkerProfil extends StatefulWidget {
  const WorkerProfil({
    super.key,
  });

  @override
  State<WorkerProfil> createState() => _WorkerProfilState();
}

class _WorkerProfilState extends State<WorkerProfil> {
  late GlobalStateModel globalStateProvider =
      Provider.of<GlobalStateModel>(context, listen: false);
  var myDescriptionTextAreaController = TextEditingController();
  var lastnameController = TextEditingController();
  var firstnameController = TextEditingController();
  var telTextFieldController = TextEditingController();
  List<String> jobsList = [
    "--selectionnez un métier--",
  ];
  var jobTextFieldValue = "";
  File? galleryFile;
  final picker = ImagePicker();

  Padding profilAttribute(
      attrName, controller, inputType, filter, callbackFunction) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            attrName,
            style: getFontStyleFromMediaSize(
              context,
              384,
              640,
              TextStyle(
                color: Colors.white,
                fontSize: myTextSmallFontSize2,
              ),
              TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: myTextBigFontSize,
              ),
            ),
          ),
          inputType == ""
              ? SizedBox(
                  width: screenSize(context)[0] / 2,
                  height: 30,
                  child: TextFormField(
                    controller: controller == "" ? null : controller,
                    decoration: myInputDecoration,
                    inputFormatters: [
                      filter == "" ? null : filter,
                    ],
                  ),
                )
              : inputType,
        ],
      ),
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
          sendFileToFtpServer(galleryFile).then((value) {
            List<String> splitedFileName = galleryFile.toString().split("/");
            String imageName = splitedFileName[splitedFileName.length - 1];
            imageName = imageName.substring(0, imageName.length - 1);
            saveInformations(context, {
              'id': globalStateProvider.currentWorker.id.toString(),
              'profil_photo': imageName,
            });
            setState(() {});
            showToast("photo modifier avec succes");
          }).onError((error, stackTrace) {
            showToast("une erreur est survenu");
            debugPrint(error.toString());
          });
        }
      },
    );
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

  @override
  void initState() {
    myDescriptionTextAreaController.text =
        globalStateProvider.currentWorker.description;
    lastnameController.text = globalStateProvider.currentWorker.lastname;
    firstnameController.text = globalStateProvider.currentWorker.firstname;
    jobTextFieldValue = globalStateProvider.currentWorker.job;
    telTextFieldController.text = globalStateProvider.currentWorker.tel;
    myDescriptionTextAreaController.text =
        globalStateProvider.currentWorker.description;
    setState(() {
      jobsList.addAll(
          Provider.of<GlobalStateModel>(context, listen: false).availableJobs);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                FluentIcons.location_12_filled,
                color: Colors.white,
                weight: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "test",
                  style: getFontStyleFromMediaSize(
                    context,
                    384,
                    640,
                    TextStyle(
                      color: Colors.white,
                      fontSize: myTextSmallFontSize2,
                    ),
                    TextStyle(
                      color: Colors.white,
                      fontSize: myTitleFontSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: ListView(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: screenSize(context)[0],
                          height: screenSize(context)[0],
                          decoration: BoxDecoration(
                            color: myPrimaryColor,
                          ),
                          child: Image.network(
                            "http://$socket/static/api/images/${Provider.of<GlobalStateModel>(context).currentWorker.profilPhoto}",
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(defaultProfilPhoto);
                            },
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _showPicker(context: context);
                            },
                            child: const Icon(Icons.edit))
                      ],
                    ),
                    profilAttribute(
                      "Nom: ",
                      lastnameController,
                      "",
                      FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'),
                          allow: true),
                      () {},
                    ),
                    profilAttribute(
                      "Prenom: ",
                      firstnameController,
                      "",
                      FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'),
                          allow: true),
                      () {},
                    ),
                    profilAttribute(
                        "Metier: ",
                        "",
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: CustomSingleSelectField<String>(
                              validator: (value) {
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
                              initialValue: jobTextFieldValue,
                              onSelectionDone: (value) {
                                setState(() {
                                  jobTextFieldValue = value.toString();
                                });
                              },
                              itemAsString: (item) => item,
                            ),
                          ),
                        ),
                        "",
                        () {}),
                    profilAttribute(
                      "Contact: ",
                      "",
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: IntlPhoneField(
                            controller: telTextFieldController,
                            validator: (value) {
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
                      ),
                      "",
                      () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: RatingBar.builder(
                        itemSize: myIconSmallSize,
                        initialRating:
                            globalStateProvider.currentWorker.rate.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: myPrimaryColor,
                        ),
                        ignoreGestures: true,
                        onRatingUpdate: (rating) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Text(
                        "Description",
                        style: getFontStyleFromMediaSize(
                          context,
                          384,
                          640,
                          const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: myTextBigFontSize,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: myDescriptionTextAreaController,
                            maxLines: 20,
                            minLines: 5,
                            decoration: myInputDecoration,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                saveInformations(context, {
                                  'id': globalStateProvider.currentWorker.id
                                      .toString(),
                                  'firstname':
                                      firstnameController.value.text.toString(),
                                  'lastname':
                                      lastnameController.value.text.toString(),
                                  'job': jobTextFieldValue.toString() ==
                                          "--selectionnez un métier--"
                                      ? ""
                                      : jobTextFieldValue,
                                  'tel': telTextFieldController.value.text
                                      .toString(),
                                  'description':
                                      myDescriptionTextAreaController.text,
                                });
                              },
                              child: const Text("Enregistrer"),
                            ),
                          ),
                        ],
                      ),
                    )
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

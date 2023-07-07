import 'package:djossi/my_classes.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
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
  var firstController = TextEditingController();

  void saveInformations() {}

  @override
  void initState() {
    super.initState();

    myDescriptionTextAreaController.text =
        globalStateProvider.currentWorker.description;
    firstController.text = globalStateProvider.currentWorker.firstname;
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
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: myPrimaryColor,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        const Text("Nom: "),
                        TextFormField(controller: lastnameController),
                      ],
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
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: myPrimaryColor),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                saveInformations();
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

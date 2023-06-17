import 'dart:math';

import 'package:djossi/workers_details.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'my_constants.dart';
import 'my_functions.dart';

class WorkersList extends StatefulWidget {
  final String categoryTitle;
  const WorkersList({super.key, required this.categoryTitle});

  @override
  State<WorkersList> createState() => _WorkersListState();
}

class _WorkersListState extends State<WorkersList> {
  Padding availableWorker(icon, firstname, lastname, contact, description) {
    final random = Random();
    final choosenColor = colorsList[random.nextInt(colorsList.length)];

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkerDetails(
                firstname: firstname,
                lastname: lastname,
                description: description,
                contact: contact,
              ),
            ),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  icon,
                  color: choosenColor,
                  size: 80,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nom: ",
                                  style: getFontStyleFromMediaSize(
                                    context,
                                    384,
                                    640,
                                    TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: myTextSmallFontSize,
                                    ),
                                    TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: myTextSmallFontSize2,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Prenom: ",
                                  style: getFontStyleFromMediaSize(
                                    context,
                                    384,
                                    640,
                                    TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: myTextSmallFontSize,
                                    ),
                                    TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: myTextSmallFontSize2,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Contact: ",
                                  style: getFontStyleFromMediaSize(
                                    context,
                                    384,
                                    640,
                                    TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: myTextSmallFontSize,
                                    ),
                                    TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: myTextSmallFontSize2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lastname,
                                    style: getFontStyleFromMediaSize(
                                      context,
                                      384,
                                      640,
                                      TextStyle(
                                        fontWeight: myNormalFontWeight,
                                        fontSize: myTextSmallFontSize,
                                      ),
                                      TextStyle(
                                        fontSize: myTextSmallFontSize2,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    firstname,
                                    style: getFontStyleFromMediaSize(
                                      context,
                                      384,
                                      640,
                                      TextStyle(
                                        fontWeight: myNormalFontWeight,
                                        fontSize: myTextSmallFontSize,
                                      ),
                                      TextStyle(
                                        fontSize: myTextSmallFontSize2,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    contact,
                                    style: getFontStyleFromMediaSize(
                                      context,
                                      384,
                                      640,
                                      TextStyle(
                                        fontWeight: myNormalFontWeight,
                                        fontSize: myTextSmallFontSize,
                                      ),
                                      TextStyle(
                                        fontSize: myTextSmallFontSize2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: myPrimaryColor,
                              size: myIconSmallSize,
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Habite a 7 Km",
                          style: getFontStyleFromMediaSize(
                            context,
                            384,
                            640,
                            TextStyle(
                              fontWeight: myNormalFontWeight,
                              fontSize: myTextSmallFontSize,
                            ),
                            TextStyle(
                              fontWeight: myNormalFontWeight,
                            ),
                          ),
                        ),
                      ],
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.categoryTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: ListView(
                children: [
                  availableWorker(
                    FluentIcons.contact_card_16_regular,
                    "Drissa",
                    "Sidibe",
                    "0556884867",
                    "Je suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibeJe suis drissa sidibe",
                  ),
                  availableWorker(
                    FluentIcons.contact_card_16_regular,
                    "Laurent",
                    "Brou",
                    "0757884867",
                    "Je suis drissa Brou",
                  ),
                  availableWorker(
                    FluentIcons.contact_card_16_regular,
                    "Killian",
                    "Mbappe",
                    "0151884867",
                    "Je suis drissa Mbappe",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:djossi/my_classes.dart';
import 'package:djossi/workers_details.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'my_constants.dart';
import 'my_functions.dart';

class WorkersList extends StatefulWidget {
  final String categoryTitle;
  const WorkersList({super.key, required this.categoryTitle});

  @override
  State<WorkersList> createState() => _WorkersListState();
}

class _WorkersListState extends State<WorkersList> {
  Padding availableWorker(
      photo, firstname, lastname, contact, description, rate) {
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
                rate: rate,
                photo: photo,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: photo,
                  ),
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
                                  GestureDetector(
                                    onTap: () {
                                      String urlTarget = contact;
                                      urlLauncher(
                                        Uri.parse('tel:$urlTarget'),
                                      );
                                    },
                                    child: Text(
                                      contact,
                                      style: getFontStyleFromMediaSize(
                                        context,
                                        384,
                                        640,
                                        TextStyle(
                                          fontWeight: myNormalFontWeight,
                                          color: myPrimaryColor,
                                        ),
                                        TextStyle(
                                          fontSize: myTextSmallFontSize2,
                                          color: myPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              RatingBar.builder(
                                itemSize: myIconSmallSize,
                                initialRating: rate.toDouble(),
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
                            ],
                          ),
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

  List<Padding> workersList() {
    List<Padding> myWorkers = [];
    for (var w in Provider.of<GlobalStateModel>(context).allWorkers) {
      if (w.job == widget.categoryTitle &&
          w.tel != Provider.of<GlobalStateModel>(context).currentWorker.tel) {
        myWorkers.add(
          availableWorker(
            Image.network(
              "http://$socket/static/api/images/${w.profilPhoto}",
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return Icon(defaultProfilPhoto);
              },
            ),
            w.firstname,
            w.lastname,
            w.tel,
            w.description,
            w.rate,
          ),
        );
      }
    }
    return myWorkers;
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
                workersList().isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.categoryTitle,
                          style: getFontStyleFromMediaSize(
                            context,
                            384,
                            640,
                            TextStyle(
                              fontSize: myTextSmallFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                            TextStyle(
                              fontSize: myTextBigFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : const Text("")
              ],
            ),
          ),
          workersList().isNotEmpty
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: ListView(children: workersList()),
                  ),
                )
              : Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Aucun ${widget.categoryTitle} n'est disponible"),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

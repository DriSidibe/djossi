import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'my_constants.dart';
import 'my_functions.dart';

class WorkerDetails extends StatefulWidget {
  final String lastname;
  final String firstname;
  final String description;
  final String contact;
  final num rate;
  const WorkerDetails({
    super.key,
    required this.lastname,
    required this.firstname,
    required this.description,
    required this.contact,
    required this.rate,
  });

  @override
  State<WorkerDetails> createState() => _WorkerDetailsState();
}

class _WorkerDetailsState extends State<WorkerDetails> {
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
                                        const TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                        const TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                        const TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.lastname,
                                        style: getFontStyleFromMediaSize(
                                          context,
                                          384,
                                          640,
                                          TextStyle(
                                            fontWeight: myNormalFontWeight,
                                          ),
                                          TextStyle(
                                            fontSize: myTextSmallFontSize2,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        widget.firstname,
                                        style: getFontStyleFromMediaSize(
                                          context,
                                          384,
                                          640,
                                          TextStyle(
                                            fontWeight: myNormalFontWeight,
                                          ),
                                          TextStyle(
                                            fontSize: myTextSmallFontSize2,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          String urlTarget = widget.contact;
                                          urlLauncher(
                                            Uri.parse('tel:$urlTarget'),
                                          );
                                        },
                                        child: Text(
                                          widget.contact,
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
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RatingBar.builder(
                                    itemSize: myIconSmallSize,
                                    initialRating: widget.rate.toDouble(),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: myPrimaryColor,
                                    ),
                                    ignoreGestures: true,
                                    onRatingUpdate: (rating) {},
                                  ),
                                ],
                              ),
                            ),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                          ),
                        ),
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
                      child: Text(
                        widget.description,
                        style: getFontStyleFromMediaSize(
                          context,
                          384,
                          640,
                          TextStyle(
                            fontSize: myTextSmallFontSize2,
                          ),
                          TextStyle(
                            fontWeight: myNormalFontWeight,
                            fontSize: myTextMediumFontSize,
                          ),
                        ),
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

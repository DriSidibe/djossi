import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'my_constants.dart';
import 'my_functions.dart';

class ChooseService extends StatefulWidget {
  final String categoryTitle;
  const ChooseService({super.key, required this.categoryTitle});

  @override
  State<ChooseService> createState() => _ChooseServiceState();
}

class _ChooseServiceState extends State<ChooseService> {
  Padding categoryDetail(icon, label) {
    final random = Random();
    final choosenColor = colorsList[random.nextInt(colorsList.length)];

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: choosenColor,
                  size: 80,
                ),
                Text(
                  label,
                ),
              ],
            ),
            Icon(
              Icons.add,
              color: choosenColor,
              size: 50,
            )
          ],
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
                  categoryDetail(
                    FluentIcons.drink_bottle_20_filled,
                    "drink buttle",
                  ),
                  categoryDetail(
                    FluentIcons.drink_bottle_20_filled,
                    "drink buttle",
                  ),
                  categoryDetail(
                    FluentIcons.drink_bottle_20_filled,
                    "drink buttle",
                  ),
                  categoryDetail(
                    FluentIcons.drink_bottle_20_filled,
                    "drink buttle",
                  ),
                  categoryDetail(
                    FluentIcons.drink_bottle_20_filled,
                    "drink buttle",
                  ),
                  categoryDetail(
                    FluentIcons.drink_bottle_20_filled,
                    "drink buttle",
                  ),
                  categoryDetail(
                    FluentIcons.drink_bottle_20_filled,
                    "drink buttle",
                  ),
                  categoryDetail(
                    FluentIcons.drink_bottle_20_filled,
                    "drink buttle",
                  ),
                  categoryDetail(
                    FluentIcons.drink_bottle_20_filled,
                    "drink buttle",
                  ),
                  categoryDetail(
                    FluentIcons.drink_bottle_20_filled,
                    "drink buttle",
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

import 'dart:math';

import 'package:djossi/base.dart';
import 'package:djossi/login_screen.dart';
import 'package:djossi/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_functions.dart';
import 'package:djossi/my_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? isConnected = prefs.getBool('connected');
  if (isConnected != null) {
    if (isConnected) {
      runApp(const Base());
    } else {
      runApp(const MyApp());
    }
  } else {
    runApp(
      const MyApp(),
    );
  }
  runApp(
    const MyApp(),
  );
}

class WelcomeScreenSliders {
  final String imageUrl;
  final String title;
  final String description;

  const WelcomeScreenSliders(
      {required this.imageUrl, required this.title, required this.description});
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<Widget> images = [];
  List<WelcomeScreenSliders> welcomeScreenSliders = [
    const WelcomeScreenSliders(
        imageUrl: "",
        title: "Disponible à Abidjan",
        description:
            "Choisissez les meuilleurs pour vos taches. Trouvez tous les professionnels de toutes vos tache ici!Choisissez les meuilleurs pour vos taches. Trouvez tous les professionnels de toutes vos tache ici!Choisissez les meuilleurs pour vos taches. !"),
    const WelcomeScreenSliders(
        imageUrl: "",
        title: "C'est mieux de bien faire",
        description:
            "Une equipe prete a vous satisfaire quelque soit la difficulté de la tache!"),
    const WelcomeScreenSliders(
        imageUrl: "",
        title: "Creez votre compte et profitez de tous nos services.",
        description:
            "Une equipe prete a vous satisfaire quelque soit la difficulté de la tache!"),
    const WelcomeScreenSliders(
        imageUrl: "",
        title: "Connecter vous si vous avez deja un compte",
        description:
            "Une equipe prete a vous satisfaire quelque soit la difficulté de la tache!"),
    const WelcomeScreenSliders(
        imageUrl: "",
        title: "C'est mieux de bien faire",
        description:
            "Une equipe prete a vous satisfaire quelque soit la difficulté de la tache!"),
  ];

  Map<String, String> languageList = {
    "FR": "Français",
    "EN": "Anglais",
  };

  List<String> deviseList = [
    "XOF",
    "EUR",
  ];

  String choosenLanguage = "FR";
  String choosenDevise = "XOF";

  void _select(String choice) {
    setState(() {
      if (languageList.containsKey(choice)) {
        choosenLanguage = choice;
      } else {
        choosenDevise = choice;
      }
    });
  }

  String listViewTitle = "Selectionnez une langue";
  String listViewSubtitle =
      "veuillez selectionnez une langue qui vous convient:";
  List<String> listViewContent = [];

  late int welcomeScreenSlidersCurrentIndex = 0;
  late bool isBottomListViewOpen = false;

  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          leading: Center(
            child: Icon(
              Icons.contact_emergency,
              color: myPrimaryColor,
            ),
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DJOSSI",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              Text(
                "App",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: PopupMenuButton(
                    onSelected: _select,
                    padding: EdgeInsets.zero,
                    // initialValue: choices[_selection],
                    itemBuilder: (BuildContext context) {
                      return languageList.values.map(
                        (value) {
                          return PopupMenuItem<String>(
                            value: languageList.keys.firstWhere(
                                (k) => languageList[k] == value,
                                orElse: () => ""),
                            child: Text(value),
                          );
                        },
                      ).toList();
                    },

                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorsList[_random.nextInt(colorsList.length)],
                      ),
                      child: Center(
                        child: Text(
                          choosenLanguage,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: PopupMenuButton(
                    onSelected: _select,
                    padding: EdgeInsets.zero,
                    // initialValue: choices[_selection],
                    itemBuilder: (BuildContext context) {
                      return deviseList.map(
                        (String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        },
                      ).toList();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: colorsList[_random.nextInt(colorsList.length)],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          choosenDevise,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: MediaQuery.of(context).size.height * 0.5,
                            initialPage: 0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                welcomeScreenSlidersCurrentIndex = index;
                              });
                            },
                          ),
                          items: welcomeScreenSliders.map(
                            (item) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              (1 / 10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: myPrimaryColor),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 30, bottom: 10),
                                          child: Text(
                                            item.title,
                                            style: getFontStyleFromMediaSize(
                                              context,
                                              384,
                                              640,
                                              TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      myTextSmallFontSize),
                                              TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: myTextBigFontSize),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          item.description,
                                          style: getFontStyleFromMediaSize(
                                            context,
                                            384,
                                            640,
                                            TextStyle(
                                                fontSize: myTextSmallFontSize),
                                            TextStyle(
                                                fontSize: myTextMediumFontSize),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: CarouselIndicator(
                              height: 10,
                              width: 10,
                              activeColor: myPrimaryColor,
                              color: Colors.grey,
                              count: welcomeScreenSliders.length,
                              index: welcomeScreenSlidersCurrentIndex,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "DJOSSI: rien ne nous arrete",
                            style: getFontStyleFromMediaSize(
                              context,
                              384,
                              640,
                              TextStyle(
                                  fontSize: myTextSmallFontSize,
                                  fontWeight: myNormalFontWeight),
                              TextStyle(
                                  fontSize: myTextMediumFontSize,
                                  fontWeight: myNormalFontWeight),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Login()),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          myPrimaryColor),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(top: 8.0, bottom: 8),
                                      child: Text(
                                        "SE CONNECTER",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Registrer()),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          myPrimaryColor),
                                    ),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(top: 8.0, bottom: 8),
                                      child: Text(
                                        "S'INSCRIRE",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'djossi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
    );
  }
}

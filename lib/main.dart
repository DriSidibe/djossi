import 'dart:math';

import 'package:djossi/login_screen.dart';
import 'package:djossi/my_constants.dart';
import 'package:djossi/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_indicator/carousel_indicator.dart';

void main() {
  runApp(const MyApp());
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

  TextStyle getFontStyleFromMediaSize(w, h, tVal, fVal) {
    return MediaQuery.of(context).size.width < 384 &&
            MediaQuery.of(context).size.height < 640
        ? tVal
        : fVal;
  }

  List<String> languageList = [
    "Français",
    "Anglais",
    "Français",
    "Anglais",
    "Français",
    "Anglais",
    "Français",
    "Anglais",
    "Français",
    "Anglais",
    "Français",
    "Anglais",
    "Français",
    "Anglais",
    "Français",
    "Anglais",
    "Français",
    "Anglais",
  ];

  List<String> deviseList = [
    "XOF",
    "Euro",
    "XOF",
    "Euro",
    "XOF",
    "Euro",
    "XOF",
    "Euro",
    "XOF",
    "Euro",
    "XOF",
    "Euro",
    "XOF",
    "Euro",
    "XOF",
    "Euro",
    "XOF",
    "Euro",
    "XOF",
    "Euro",
    "XOF",
    "Euro",
    "XOF",
    "Euro",
    "XOF",
    "Euro",
  ];

  late int welcomeScreenSlidersCurrentIndex = 0;
  late bool isLanguageButtonClicked = false;
  late bool isDeviseButtonClicked = false;

  final _random = Random();

  Column getButtomListView(title, subtitle, content) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(""),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isDeviseButtonClicked = !isDeviseButtonClicked;
                        isLanguageButtonClicked = !isLanguageButtonClicked;
                      });
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: myPrimaryColor),
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              Text(
                                subtitle,
                                style: TextStyle(
                                  fontSize: myTextMediumFontSize2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: content.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colorsList[
                                            _random.nextInt(colorsList.length)],
                                      ),
                                      child: const SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Icon(
                                          Icons.abc,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    content[index],
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.circle,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
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
                  padding: const EdgeInsets.only(
                    right: 8,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isDeviseButtonClicked = !isDeviseButtonClicked;
                        isLanguageButtonClicked = !isLanguageButtonClicked;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorsList[_random.nextInt(colorsList.length)],
                      ),
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Text(
                            "FR",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isDeviseButtonClicked = !isDeviseButtonClicked;
                        isLanguageButtonClicked = !isLanguageButtonClicked;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorsList[_random.nextInt(colorsList.length)],
                      ),
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Text(
                            "XOF",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
          backgroundColor: Colors.white,
        ),
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Padding(
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
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
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
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
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
                                                style:
                                                    getFontStyleFromMediaSize(
                                                  384,
                                                  640,
                                                  TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          myTextSmallFontSize),
                                                  TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          myTextBigFontSize),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              item.description,
                                              style: getFontStyleFromMediaSize(
                                                384,
                                                640,
                                                TextStyle(
                                                    fontSize:
                                                        myTextSmallFontSize),
                                                TextStyle(
                                                    fontSize:
                                                        myTextMediumFontSize),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
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
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  myPrimaryColor),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              top: 8.0, bottom: 8),
                                          child: Text(
                                            "SE CONNECTER",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
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
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  myPrimaryColor),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.only(
                                              top: 8.0, bottom: 8),
                                          child: Text(
                                            "S'INSCRIRE",
                                            style:
                                                TextStyle(color: Colors.white),
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
            AnimatedContainer(
              height: isLanguageButtonClicked
                  ? MediaQuery.of(context).size.height * 0.8
                  : 0,
              duration: const Duration(milliseconds: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  isLanguageButtonClicked
                      ? getButtomListView(
                          "Selzctionnez une langue",
                          "veuillez selectionnez une langue qui vous convient:",
                          languageList)
                      : const Text(""),
                  isDeviseButtonClicked
                      ? getButtomListView(
                          "Selzctionnez une devise",
                          "veuillez selectionnez une devise qui vous convient:",
                          deviseList)
                      : const Text(""),
                ],
              ),
            ),
          ],
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

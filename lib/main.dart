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
            "Choisissez les meuilleurs pour vos taches. Trouvez tous les professionnels de toutes vos tache ici!"),
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

  late int welcomeScreenSlidersCurrentIndex = 0;

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
                    onTap: () {},
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
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
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: myPrimaryColor,
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
                            height: MediaQuery.of(context).size.height / 2.5,
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
                                    width: MediaQuery.of(context).size.width,
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
                                          padding:
                                              const EdgeInsets.only(top: 30),
                                          child: Text(
                                            item.title,
                                            style: const TextStyle(
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          item.description,
                                          style:
                                              const TextStyle(fontSize: 10.0),
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
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("DJOSSI: rien ne nous arrete"),
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
              )
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

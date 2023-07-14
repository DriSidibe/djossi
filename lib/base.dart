import 'package:djossi/available_workers_list.dart';
import 'package:djossi/change_password.dart';
import 'package:djossi/worker_profil.dart';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:flag/flag.dart';

import 'my_classes.dart';
import 'my_functions.dart';
import 'package:djossi/my_constants.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  bool isPasswordVisible = true;

  @override
  void didChangeDependencies() {
    getCurrentWorker(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    AcceuilScreen(),
    ProfilScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: const Color.fromARGB(255, 110, 107, 107),
          showUnselectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              tooltip: "Accueil",
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              tooltip: "Profil",
              icon: Icon(Icons.contact_emergency),
              label: 'Profil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: myPrimaryColor,
          onTap: _onItemTapped,
        ),
      ),
      getWifiUnavailableWidget(context),
    ]);
  }
}

class AcceuilScreen extends StatefulWidget {
  const AcceuilScreen({super.key});

  @override
  State<AcceuilScreen> createState() => _AcceuilScreenState();
}

class _AcceuilScreenState extends State<AcceuilScreen> {
  Padding jobsCard(title, image) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkersList(
                categoryTitle: title,
              ),
            ),
          );
        },
        child: Card(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: myPrimaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                height: 150,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title,
                          style: getFontStyleFromMediaSize(
                            context,
                            384,
                            640,
                            TextStyle(
                              color: Colors.white,
                              fontSize: myTextSmallFontSize,
                            ),
                            TextStyle(
                              color: Colors.white,
                              fontSize: myTextSmallFontSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
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

  Column jobsIcon(icon, title) {
    final random = Random();
    final choosenColor = colorsList[random.nextInt(colorsList.length)];

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkersList(
                  categoryTitle: title,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(blurRadius: 4, color: choosenColor),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Icon(
                    icon,
                    color: choosenColor,
                  ),
                )),
          ),
        ),
        Wrap(children: [
          Text(
            title,
            style: getFontStyleFromMediaSize(
              context,
              384,
              640,
              TextStyle(
                fontSize: myTextSmallFontSize2,
              ),
              TextStyle(
                fontSize: myTextSmallFontSize2,
              ),
            ),
          ),
        ]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
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
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    "http://$socket/static/api/images/${Provider.of<GlobalStateModel>(context).currentWorker.profilPhoto}",
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(defaultProfilPhoto);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 8.0,
                bottom: 8,
              ),
              child: Text(
                "LAISSEZ DJOSSI VOUS SIMPLIFIER LA VIE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return jobsCard(
                        Provider.of<GlobalStateModel>(context)
                            .availableJobs[index],
                        "");
                  },
                  itemCount: Provider.of<GlobalStateModel>(context)
                      .availableJobs
                      .length,
                ),
              ),
            ),
          ],
        ),
      ),
      getWifiUnavailableWidget(context),
    ]);
  }
}

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final _random = Random();

  Future<Worker> getCurrentWorker() async {
    return getWorkerBy(
      (await SharedPreferences.getInstance())
          .getInt('currentWorkerId')
          .toString(),
    );
  }

  Container settingSectionRow(icon, title, callbackAction) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color.fromARGB(255, 222, 222, 222),
          )),
      child: GestureDetector(
        onTap: callbackAction,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              colorsList[_random.nextInt(colorsList.length)]),
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(title),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column settingSection(title, List<Container> settingSectionRowList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
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
        Column(
          children: settingSectionRowList,
        )
      ],
    );
  }

  dynamic globalStateProvider = Provider.of<GlobalStateModel>;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WorkerProfil(),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(color: myPrimaryColor),
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 50, left: 20),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        "http://$socket/static/api/images/${Provider.of<GlobalStateModel>(context).currentWorker.profilPhoto}",
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(defaultProfilPhoto);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "${globalStateProvider(context).currentWorker.firstname} ${globalStateProvider(context).currentWorker.lastname}"
                                .toUpperCase(),
                            style: getFontStyleFromMediaSize(
                              context,
                              384,
                              640,
                              const TextStyle(
                                color: Colors.white,
                              ),
                              TextStyle(
                                color: Colors.white,
                                fontSize: myTextBigFontSize,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "${globalStateProvider(context).currentWorker.email}",
                          style: getFontStyleFromMediaSize(
                            context,
                            384,
                            640,
                            const TextStyle(
                              color: Colors.white,
                            ),
                            TextStyle(
                              color: Colors.white,
                              fontSize: myTextMediumFontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 222, 222, 222),
            ),
            child: Column(
              children: [
                settingSection("Gérer mes paramètres de compte", [
                  settingSectionRow(
                      Icons.phone_android, "Vérifier votre mobile", () {}),
                  settingSectionRow(Icons.email, "Vérifier votre email", () {}),
                  settingSectionRow(Icons.contact_emergency, "Gérer mon profil",
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WorkerProfil(),
                      ),
                    );
                  }),
                  settingSectionRow(Icons.key, "Changer mon mot de passe", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePassword(),
                      ),
                    );
                  }),
                  settingSectionRow(Icons.language, "Changer de langue", () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SafeArea(
                          child: Wrap(
                            children: <Widget>[
                              ListTile(
                                leading: const Flag.fromString("FR",
                                    height: 50, width: 50, fit: BoxFit.fill),
                                title: Text(langageList[0]),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: const Flag.fromString("GB",
                                    height: 50, width: 50, fit: BoxFit.fill),
                                title: Text(langageList[1]),
                                onTap: () {},
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ]),
                settingSection("Déconnexion", [
                  settingSectionRow(
                      FluentIcons.power_20_filled, "Se déconnecter", () async {
                    await (await SharedPreferences.getInstance())
                        .setBool('connected', false)
                        .then(
                      (value) {
                        Fluttertoast.showToast(
                          msg: "Vous etes déconnecté avec succes",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        context.goNamed('login');
                      },
                    );
                  }),
                ])
              ],
            ),
          )
        ],
      ),
    );
  }
}

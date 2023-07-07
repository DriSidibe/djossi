import 'dart:convert';

import 'package:djossi/my_constants.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'my_classes.dart';

TextStyle getFontStyleFromMediaSize(BuildContext context, w, h, tVal, fVal) {
  return MediaQuery.of(context).size.width < 384 &&
          MediaQuery.of(context).size.height < 640
      ? tVal
      : fVal;
}

Future<void> urlLauncher(url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url\n');
  }
}

Future<Worker> getWorkerBy(value) async {
  var client = http.Client();
  try {
    var response = await client.get(
      Uri.http(
        "$dbServerName:$dbServerPort",
        value.toString().length <= 10
            ? "workers/by/id/$value/"
            : "workers/by/teloremail/$value/",
      ),
    );
    Map<String, dynamic> responseToMap = json.decode(response.body)[0];
    if (response.body.isNotEmpty) {
      return Worker(
          responseToMap["id"],
          responseToMap["firstname"],
          responseToMap["lastname"],
          responseToMap["email"],
          responseToMap["job"],
          responseToMap["tel"],
          responseToMap["profil_photo"],
          responseToMap["hashed_password"],
          responseToMap["rate"] ?? 0,
          responseToMap["description"] ?? "");
    }
    return defaultWorker;
  } catch (_) {
    debugPrint("error----------: ${_.toString()}");
    return defaultWorker;
  }
}

Future<bool> isEmailOrTelAlreadyExist(value) async {
  var client = http.Client();
  try {
    var response = await client.get(
      Uri.http(
        "$dbServerName:$dbServerPort",
        "workers/by/teloremail/$value/",
      ),
    );
    if (response.body.isEmpty) {
      return false;
    } else {
      return true;
    }
  } on Exception catch (_) {
    Fluttertoast.showToast(
        msg: "Une erreur est survenue",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
    return true;
  }
}

Future<http.Response> getRessourcesFromApi(
    String socket, String rl, Map<String, dynamic> params) async {
  var client = http.Client();
  dynamic result = await client.get(
    Uri.http(
      socket,
      rl,
      params,
    ),
  );
  client.close();
  return result;
}

//database
Future<void> createTables(Database database) async {
  await database.execute("""CREATE TABLE currentUser(
        id INTEGER,
        firstname TEXT,
        lastname TEXT,
        email TEXT,
        job TEXT,
        tel TEXT,
        profilPhoto TEXT,
        hashedPassword TEXT,
        rate INTEGER,
        description TEXT
      )
      """);
}

Future<Database> db() async {
  return openDatabase(
    'djossi.db',
    version: 1,
    onCreate: (Database database, int version) async {
      await createTables(database);
    },
  );
}

Future<void> deleteAllItem(String tableName) async {
  final mydb = await db();
  try {
    await mydb.rawDelete("DELETE FROM $tableName").then((value) =>
        debugPrint("delete ald current user in local db with success"));
  } catch (err) {
    debugPrint("Something went wrong when deleting all items");
  }
}

Future<void> replaceExistingCurrentWorker(
    Worker worker, String tableName) async {
  final mydb = await db();

  deleteAllItem("currentUser").then((value) async {
    final data = {
      "id": worker.id,
      "firstname": worker.firstname,
      "lastname": worker.lastname,
      "email": worker.email,
      "job": worker.job,
      "tel": worker.tel,
      "profilPhoto": worker.profilPhoto,
      "hashedPassword": worker.hashedPassword,
    };
    await mydb
        .insert(tableName, data, conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) =>
            debugPrint("register new user in local db with success"));
  }).onError((error, stackTrace) {
    debugPrint("can't delete table items");
  });
}

Future<List<Map<String, dynamic>>> getCurrentWorkerFromDatabase(
    String tableName) async {
  final mydb = await db();
  return mydb.query(tableName);
}
//-------------------

Visibility getWifiUnavailableWidget(BuildContext context) {
  return Visibility(
    visible: Provider.of<InternetConnectionStatus>(context) ==
        InternetConnectionStatus.disconnected,
    child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.9),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(
            FluentIcons.wifi_off_20_filled,
            color: Colors.white,
            size: 200,
          ),
          Text(
            "Aucune connexion à internet!",
            style: getFontStyleFromMediaSize(
              context,
              384,
              640,
              TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: myTextSmallFontSize,
              ),
              TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: myTextBigFontSize,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

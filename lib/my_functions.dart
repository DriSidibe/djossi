import 'dart:convert';

import 'package:djossi/my_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        responseToMap["id"]!,
        responseToMap["firstname"]!,
        responseToMap["lastname"]!,
        responseToMap["email"]!,
        responseToMap["job"]!,
        responseToMap["tel"]!,
        responseToMap["profil_photo"]!,
        responseToMap["hashed_password"]!,
      );
    }
    return Worker(
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    );
  } catch (_) {
    return Worker(
      0,
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    );
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

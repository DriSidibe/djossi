import 'dart:convert';

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
        '192.168.1.191:8000',
        "workers/by/teloremail/$value/",
      ),
    );
    Map<String, dynamic> responseToMap = json.decode(response.body)[0];
    if (response.body.isNotEmpty) {
      return Worker(
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
        '192.168.1.191:8000',
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

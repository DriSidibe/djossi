import 'package:flutter/material.dart';

class Worker {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String job;
  final String tel;
  final String profilPhoto;
  final String hashedPassword;

  Worker(this.id, this.firstname, this.lastname, this.email, this.job, this.tel,
      this.profilPhoto, this.hashedPassword);

  @override
  String toString() {
    return ("{$firstname, $lastname, $email, $job, $tel, $profilPhoto, $hashedPassword}");
  }
}

class GlobalStateModel extends ChangeNotifier {
  Worker _currentWorker = Worker(
    0,
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  );

  Worker get currentWorker => _currentWorker;

  set currentWorker(Worker newWorker) {
    _currentWorker = newWorker;
    notifyListeners();
  }
}

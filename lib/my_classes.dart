import 'package:djossi/my_constants.dart';
import 'package:flutter/material.dart';

class Worker {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String job;
  final String tel;
  late final String profilPhoto;
  final String hashedPassword;
  final int rate;
  final String description;

  Worker(this.id, this.firstname, this.lastname, this.email, this.job, this.tel,
      this.profilPhoto, this.hashedPassword, this.rate, this.description);

  @override
  String toString() {
    return ("{$firstname, $lastname, $email, $job, $tel, $profilPhoto, $hashedPassword, $rate, $description}");
  }
}

class GlobalStateModel extends ChangeNotifier {
  Worker _currentWorker = defaultWorker;
  List<String> _availableJobs = [];
  List<Worker> _allWorkers = [];

  Worker get currentWorker => _currentWorker;
  set currentWorker(Worker newWorker) {
    _currentWorker = newWorker;
    notifyListeners();
  }

  List<Worker> get allWorkers => _allWorkers;
  set allWorkers(List<Worker> newWorkers) {
    _allWorkers = newWorkers;
    notifyListeners();
  }

  List<String> get availableJobs => _availableJobs;
  set availableJobs(List<String> newJobs) {
    _availableJobs = newJobs;
    notifyListeners();
  }
}

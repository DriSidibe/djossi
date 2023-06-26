class Worker {
  final String firstname;
  final String lastname;
  final String email;
  final String job;
  final String tel;
  final String profilPhoto;
  final String hashedPassword;

  Worker(this.firstname, this.lastname, this.email, this.job, this.tel,
      this.profilPhoto, this.hashedPassword);

  String get getFirstname {
    return firstname;
  }

  String get getLastname {
    return lastname;
  }

  String get getEmail {
    return email;
  }

  String get getJob {
    return job;
  }

  String get getTel {
    return tel;
  }

  String get getProfilPhoto {
    return profilPhoto;
  }

  String get getHashedPassword {
    return hashedPassword;
  }

  @override
  String toString() {
    return ("{$firstname, $lastname, $email, $job, $tel, $profilPhoto, $hashedPassword}");
  }
}

class UserLogin {
  String cabang;
  String pusat;
  String session;
  String subCabang;

  String id;

  UserLogin(
      {required this.cabang,
      required this.pusat,
      required this.session,
      required this.subCabang,
      required this.id});

  factory UserLogin.loginUser(Map<String, dynamic> object) {
    return UserLogin(
        id: object["id"].toString(),
        pusat: object["pusat"].toString(),
        session: object["session"].toString(),
        subCabang: object["subcabang"].toString(),
        cabang: object['cabang'].toString());
  }
}

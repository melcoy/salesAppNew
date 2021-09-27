class CustomerAddModel {
  String name;
  String alamat;
  String kota;
  String provinsi;
  String decisionmaker;
  String hp;
  String sex;
  String kelurahan;
  String kecamatan;
  String kodepos;
  String email;

  CustomerAddModel(
      {required this.name,
      required this.alamat,
      required this.kota,
      required this.provinsi,
      required this.decisionmaker,
      required this.hp,
      required this.sex,
      required this.kelurahan,
      required this.kecamatan,
      required this.kodepos,
      required this.email});

  Map<String, dynamic> toJson() => {
        "name": name,
        "alamat": alamat,
        "kota": kota,
        "provinsi": provinsi,
        "decisionmaker": decisionmaker,
        "hp": hp,
        "sex": sex,
        "kelurahan": kelurahan,
        "kecamatan": kecamatan,
        "kodepos": kodepos,
        "email": email,
      };
}

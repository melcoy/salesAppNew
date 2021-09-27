class CustomerAddDto {
  String name;
  String alamat;
  String kota;
  String provinsi;
  // String decisionmaker;
  String hp;
  String sex;
  // String kelurahan;
  // String kecamatan;
  // String kodepos;
  String email;

  CustomerAddDto(
      {required this.name,
      required this.alamat,
      required this.kota,
      required this.provinsi,
      // this.decisionmaker,
      required this.hp,
      required this.sex,
      // this.kelurahan,
      // this.kecamatan,
      // this.kodepos,
      required this.email});
}

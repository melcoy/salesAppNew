class ListTruckDto {
  String id;
  String discount;
  String type;
  List<String> bonus;
  String harga;

  ListTruckDto(
      {required this.id,
      required this.discount,
      required this.type,
      required this.bonus,
      required this.harga});
}

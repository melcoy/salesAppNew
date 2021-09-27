class VisitPlanListSales {
  VisitPlanListSales({
    required this.tipebayar,
    required this.quantity,
    required this.raihan,
    required this.produkid,
    required this.customeraddress,
    required this.tanggal,
    required this.visited,
    required this.customer,
    required this.produk,
    required this.visitplanid,
    required this.customerid,
    required this.bonus,
    required this.number,
    required this.discount,
    required this.bonustambahan,
    required this.id,
  });

  String tipebayar;
  String quantity;
  String raihan;
  String produkid;
  String customeraddress;
  String tanggal;
  String visited;
  String customer;
  String produk;
  String visitplanid;
  String customerid;
  List<Bonus> bonus;
  String number;
  String discount;
  String bonustambahan;
  String id;

  factory VisitPlanListSales.fromJson(Map<String, dynamic> json) =>
      VisitPlanListSales(
        tipebayar: json["tipebayar"].toString(),
        quantity: json["quantity"].toString(),
        raihan: json["raihan"].toString(),
        produkid: json["produkid"].toString(),
        customeraddress: json["customeraddress"],
        tanggal: DateTime.parse(json["tanggal"]).toLocal().toString(),
        visited: DateTime.parse(json["visited"]).toLocal().toString(),
        customer: json["customer"].toString(),
        produk: json["produk"].toString(),
        visitplanid: json["visitplanid"].toString(),
        customerid: json["customerid"].toString(),
        bonus: List<Bonus>.from(json["bonus"].map((x) => Bonus.fromJson(x))),
        number: json["number"].toString(),
        discount: json["discount"].toDouble().toString(),
        bonustambahan: json["bonustambahan"].toString(),
        id: json["id"].toString(),
      );

  // Map<String, dynamic> toJson() => {
  //     "tipebayar": tipebayar,
  //     "quantity": quantity,
  //     "raihan": raihan,
  //     "produkid": produkid,
  //     "customeraddress": customeraddress,
  //     "tanggal": tanggal.toIso8601String(),
  //     "visited": visited.toIso8601String(),
  //     "customer": customer,
  //     "produk": produk,
  //     "visitplanid": visitplanid,
  //     "customerid": customerid,
  //     "bonus": List<dynamic>.from(bonus.map((x) => x.toJson())),
  //     "number": number,
  //     "discount": discount,
  //     "bonustambahan": bonustambahan,
  //     "id": id,
  // };
}

class Bonus {
  Bonus({
    required this.name,
  });

  String name;

  factory Bonus.fromJson(Map<String, dynamic> json) => Bonus(
        name: json["name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

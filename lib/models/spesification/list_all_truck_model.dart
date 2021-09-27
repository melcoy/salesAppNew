class ListAllTruckModel {
  ListAllTruckModel({
    required this.pusatId,
    required this.stock,
    required this.bonus,
    required this.deskripsi,
    required this.name,
    required this.photos,
    required this.type,
    required this.id,
    required this.harga,
    required this.promo,
    required this.discount,
    required this.pembayaran,
    required this.pusat,
  });

  String pusatId;
  String stock;
  List<Bonus> bonus;
  String deskripsi;
  String name;
  List<Photo> photos;
  String type;
  String id;
  String harga;
  String promo;
  String discount;
  String pembayaran;
  String pusat;

  factory ListAllTruckModel.fromJson(Map<String, dynamic> json) =>
      ListAllTruckModel(
        pusatId: json["pusat_id"].toString(),
        stock: json["stock"].toString(),
        bonus: List<Bonus>.from(json["bonus"].map((x) => Bonus.fromJson(x))),
        deskripsi: json["deskripsi"].toString(),
        name: json["name"].toString(),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        type: json["type"].toString(),
        id: json["id"].toString(),
        harga: json["harga"].toString(),
        promo: json["promo"].toString(),
        discount: json["discount"].toString(),
        pembayaran: json["pembayaran"].toString(),
        pusat: json["pusat"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "pusat_id": pusatId,
        "stock": stock,
        "bonus": List<dynamic>.from(bonus.map((x) => x.toJson())),
        "deskripsi": deskripsi,
        "name": name,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "type": type,
        "id": id,
        "harga": harga,
        "promo": promo,
        "discount": discount,
        "pembayaran": pembayaran,
        "pusat": pusat,
      };
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

class Photo {
  Photo({
    required this.url,
  });

  String url;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        url: json["url"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
